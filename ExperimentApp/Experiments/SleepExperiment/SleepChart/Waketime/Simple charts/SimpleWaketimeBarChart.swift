//
//  SimpleWaketimeBarChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct SimpleWaketimeBarChart: View {
    var experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable
    @State var interval: Date = Date()
    @State var chartEntries: [WaketimeBarChartEntry] = []
    @State var barChartEntries: [SimpleSleepDependentHistory.BarChartEntry] = []
    @State var notEnoughEntries: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                if(notEnoughEntries){
                    Image(systemName: "gearshape.2.fill")
                    Text("Add more entries to analyze your data.")
                } else if(experiment.dependentVariable == .productivity||dependentVariable == .productivity){
                    Image(systemName: "gearshape.2.fill")
                    Text("When you woke up between ") + Text(interval.simplifyDateToTimeString()).bold() + Text(" and ") + Text(interval.addMinutesToDate(minutesToAdd: 30).simplifyDateToTimeString()).bold() + Text(", you had the highest productivity!")
                } else if(experiment.dependentVariable == .quality||dependentVariable == .quality){
                    Image(systemName: "sun.max")
                    Text("When you woke up between ") + Text(interval.simplifyDateToTimeString()).bold() + Text(" and ") + Text(interval.addMinutesToDate(minutesToAdd: 30).simplifyDateToTimeString()).bold() + Text(", you had the highest quality of day!")
                }
            }
            if(notEnoughEntries){
                EmptyChart()
            } else {
                Chart(chartEntries){ entry in
                    if(entry.isOptimal){
                        BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value)).foregroundStyle(Color(.green))
                    } else if(entry.hasNoData){
                        BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value)).foregroundStyle(Color(.gray))
                    }else {
                        BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value))
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .frame(height: 120)
            }
        }.onAppear(){
            switch(experiment.getOptimalWaketimeInterval(dependentVariable: dependentVariable, requiredEntries: 1)){
            case .success(let optimalInterval):
                interval = optimalInterval
            case .failure(let error):
                print("Failure: \(error.description)")
                interval = Date()
                notEnoughEntries = true
            }
            let intervalMinutes = SleepExperiment.getMinutes(from: interval)
            
            var lowestChartBarMark = intervalMinutes
            
            for chartBarMark in stride(from: intervalMinutes-60, through: intervalMinutes+60, by: 30){
                
                chartEntries.append(WaketimeBarChartEntry(experiment: experiment, dependentVariable: dependentVariable, time: chartBarMark, isOptimal: chartBarMark == intervalMinutes))
                 
            }
        }
    }
}

struct SimpleWaketimeBarChart_Previews: PreviewProvider {
    static var previews: some View {
        SimpleWaketimeBarChart(experiment: SleepExperiment.waketimeEmpty, dependentVariable: .productivity)
    }
}
