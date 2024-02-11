//
//  SimpleBedtimeBarChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI
import Charts
struct SimpleBedtimeBarChart: View {
    var experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable
    @State var interval: Date = Date()
    @State var chartEntries: [BedtimeBarChartEntry] = []
    @State var notEnoughEntries: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                if(notEnoughEntries){
                    Image(systemName: "sun.max")
                    Text("Add more entries to analyze your bedtimes.")
                }else if(experiment.dependentVariable == .productivity||dependentVariable == .productivity){
                    Image(systemName: "gearshape.2.fill")
                    Text("When you slept between ") + Text(interval.simplifyDateToTimeString()).bold() + Text(" and ") + Text(interval.addMinutesToDate(minutesToAdd: 30).simplifyDateToTimeString()).bold() + Text(", you had the highest productivity!")
                } else if(experiment.dependentVariable == .quality||dependentVariable == .quality){
                    Image(systemName: "sun.max")
                    Text("When you slept between ") + Text(interval.simplifyDateToTimeString()).bold() + Text(" and ") + Text(interval.addMinutesToDate(minutesToAdd: 30).simplifyDateToTimeString()).bold() + Text(", you had the highest quality of day!")
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
            
            switch(experiment.getOptimalBedtimeInterval(dependentVariable: dependentVariable, requiredEntries: 2, lowEndpoint: nil, highEndpoint: nil)){
            case .success(let optimalInterval):
                interval = optimalInterval
                print("Sucess!")
            case .failure(let error):
                print("YOu suck  a lot \(error.description)" )
                notEnoughEntries = true
            }
            
            var intervalMinutes = SleepExperiment.getMinutes(from: interval)
            if(intervalMinutes<720){
                intervalMinutes = intervalMinutes + 1440
            }
            
            for chartBarMark in stride(from: intervalMinutes-60, through: intervalMinutes+60, by: 30){
                
                chartEntries.append(BedtimeBarChartEntry(experiment: experiment, dependentVariable: dependentVariable, time: chartBarMark, isOptimal: chartBarMark == intervalMinutes))
                 
            }
        }
    }
}

struct SimpleBedtimeBarChart_Previews: PreviewProvider {
    static var previews: some View {
        SimpleBedtimeBarChart(experiment: SleepExperiment.bedtimeSampleExperiment2, dependentVariable: .productivity)
    }
}
