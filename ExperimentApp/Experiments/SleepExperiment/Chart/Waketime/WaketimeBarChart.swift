//
//  WaketimeBarChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct WaketimeBarChart: View {
    var experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable
    @State var chartEntries: [WaketimeBarChartEntry] = []
    var body: some View {
        VStack(alignment:.leading){
            Text("Hey :)")
            Chart(chartEntries){ entry in
                if(entry.isOptimal){
                    BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value)).foregroundStyle(Color(.green))
                } else {
                    BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value))
                }
            }.frame(height: 300)
        }.onAppear(){
            var interval = Date()
            
            switch(experiment.getOptimalWaketimeInterval(size: 30, dependentVariable: dependentVariable)){
            case .success(let optimalInterval):
                interval = optimalInterval
            case .failure:
                interval = Date()
            }
            
            let intervalMinutes = SleepExperiment.getMinutes(from: interval)
            
            //1. use least waketime to find a smallest range that will generate a bar mark (in line with the optimal interval)
            var lowestChartBarMark = intervalMinutes
            
            while(lowestChartBarMark > experiment.getLeastWaketimeMinutes()){
                lowestChartBarMark = lowestChartBarMark - 30
            }
            
            //2. use most waketime to find a highest range that will generate a bar mark
            var highestChartBarMark = intervalMinutes
            while(highestChartBarMark <= experiment.getMostWaketimeMinutes()){
                highestChartBarMark = highestChartBarMark + 30
            }
            if(highestChartBarMark > intervalMinutes){
                highestChartBarMark = highestChartBarMark - 30
            }
            //print("LowestchartBarMark = \(lowestChartBarMark), highestchartbarmark = \(highestChartBarMark), leastwaketimeminutes = \(experiment.getLeastWaketimeMinutes()), mostwaketimeMinutes = \(experiment.getMostWaketimeMinutes()) optimal interval = \(intervalMinutes)")
            //3. initiate the waketimebarchartentries
            for chartBarMark in stride(from: lowestChartBarMark, through: highestChartBarMark, by: 30){
                
                chartEntries.append(WaketimeBarChartEntry(experiment: experiment, dependentVariable: dependentVariable, time: chartBarMark, isOptimal: chartBarMark == intervalMinutes))
            }
            
        }
    }

}

struct WaketimeBarChart_Previews: PreviewProvider {
    static var previews: some View {
        WaketimeBarChart(experiment: SleepExperiment.waketimeSampleExperiment, dependentVariable: .productivity)
    }
}
