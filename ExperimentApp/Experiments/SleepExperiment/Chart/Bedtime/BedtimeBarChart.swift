//
//  BedtimeBarChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI
import Charts

struct BedtimeBarChart: View {
    var experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable
    
    @State var chartEntries: [BedtimeBarChartEntry] = []
    
    
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
            switch(experiment.getOptimalBedtimeInterval(size: 30, dependentVariable: dependentVariable)){
            case .success(let optimalInterval):
                interval = optimalInterval
            case .failure:
                interval = Date()
            }
            var intervalMinutes = SleepExperiment.getMinutes(from: interval)
            if(intervalMinutes<720){
                intervalMinutes = intervalMinutes + 1440
            }
            //1. use least bedtime to find a smallest range that will generate a bar mark (in line with the optimal interval)
            var lowestChartBarMark = intervalMinutes
            while(lowestChartBarMark > experiment.getLeastBedtimeMinutes()){
                lowestChartBarMark = lowestChartBarMark - 30
            }
            
            //2. use most bedtime to find a highest range that will generate a bar mark
            var highestChartBarMark = intervalMinutes
            while(highestChartBarMark <= experiment.getMostBedtimeMinutes()){
                highestChartBarMark = highestChartBarMark + 30
            }
            if(highestChartBarMark > intervalMinutes){
                highestChartBarMark = highestChartBarMark - 30
            }
            //3. initiate the bedtimebarchartentries
            for chartBarMark in stride(from: lowestChartBarMark, through: highestChartBarMark, by: 30){
                
                chartEntries.append(BedtimeBarChartEntry(experiment: experiment, dependentVariable: dependentVariable, time: chartBarMark, isOptimal: chartBarMark == intervalMinutes))
            }
            
        }
    }
    
    
    
    
}

struct BedtimeBarChart_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeBarChart(experiment: SleepExperiment.bedtimeSampleExperiment, dependentVariable: .quality)
    }
}
