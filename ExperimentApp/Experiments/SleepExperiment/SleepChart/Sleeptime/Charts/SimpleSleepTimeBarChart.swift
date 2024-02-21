//
//  SimpleSleepTimeBarChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct SimpleSleepTimeBarChart: View {
    var experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable
    @State var interval: Date = Date()
    @State var chartEntries: [SleepTimeBarChartEntry] = []
    @State var notEnoughEntries: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                if(notEnoughEntries){
                    Image(systemName: "gearshape.2.fill")
                    if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                        Text("Add more entries to view how your sleep time is associated with quality of day.")
                    } else {
                        Text("Add more entries to view how your sleep time is associated with productivity.")
                    }
                } else if(experiment.dependentVariable == .productivity||dependentVariable == .productivity){
                    Image(systemName: "gearshape.2.fill")
                    Text("When you slept between ") + Text(interval.simplifyDateToHMM()).bold() + Text(" and ") + Text(interval.addMinutesToDate(minutesToAdd: 30).simplifyDateToHMM()).bold() + Text(", you had the highest productivity!")
                } else if(experiment.dependentVariable == .quality||dependentVariable == .quality){
                    Image(systemName: "sun.max")
                    Text("When you slept between ") + Text(interval.simplifyDateToHMM()).bold() + Text(" and ") + Text(interval.addMinutesToDate(minutesToAdd: 30).simplifyDateToHMM()).bold() + Text(", you had the highest quality of day!")
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
                    } else {
                        BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value))
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .frame(height: 120)
            }
        }.onAppear(){
            switch(experiment.getOptimalSleepTimeInterval(dependentVariable: dependentVariable, requiredEntries: 2)){
            case .success(let optimalInterval):
                interval = optimalInterval
            case .failure(let error):
                print("Failure: \(error.description)")
                interval = Date()
                notEnoughEntries = true
            }
            let intervalMinutes = SleepExperiment.getMinutes(from: interval)
            for chartBarMark in stride(from: intervalMinutes-60, through: intervalMinutes+60, by: 30){
                chartEntries.append(SleepTimeBarChartEntry(experiment: experiment, dependentVariable: dependentVariable, time: chartBarMark, isOptimal: chartBarMark == intervalMinutes))
            }
        }
    }
}

struct SimpleSleepTimeBarChart_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSleepTimeBarChart(experiment: SleepExperiment.hoursSleptSampleExperiment, dependentVariable: .quality)
    }
}
