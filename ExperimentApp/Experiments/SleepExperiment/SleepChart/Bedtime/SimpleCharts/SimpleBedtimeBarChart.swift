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
        NavigationStack{
            
            VStack(alignment: .leading){
                HStack{
                    getMessage().foregroundColor(.black)
                }.padding(.horizontal)
                Divider()
                if(notEnoughEntries){
                    EmptyChart()
                } else {
                    Chart(chartEntries){ entry in
                        if(entry.isOptimal){
                            BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value)).foregroundStyle(Color(.green))
                        }else if(entry.hasNoData){
                            BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value)).foregroundStyle(Color(.gray))
                        }else {
                            BarMark(x: .value("Time", entry.time), y: .value("Dependent Variable", entry.value))
                        }
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .frame(height: 120)
                }
                NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: dependentVariable)){
                    Spacer()
                    Text("View Chart")
                }
            }.onAppear(){
                fillData()
            }.frame(height: 220)
        }
        
    }
    func fillData(){
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
    func getMessage() -> AnyView{
        if(notEnoughEntries){
            return AnyView(HStack{
                Image(systemName: "sun.max")
                Spacer()
                Text("Add more entries to analyze your bedtimes.")
            }
            )
        }else if(experiment.dependentVariable == .productivity||dependentVariable == .productivity){
            return AnyView(HStack{
                Image(systemName: "gearshape.2.fill")
                Spacer()
                Text("You had the highest productivity when you slept between ") + Text(interval.simplifyDateToHMM()).bold() + Text(" and ") + Text(interval.addMinutesToDate(minutesToAdd: 30).simplifyDateToTimeString()).bold() + Text(".")
            }
            )
        } else{
            return AnyView(HStack{
                Image(systemName: "sun.max")
                Spacer()
                Text("You had the highest quality of day when you slept between ") + Text(interval.simplifyDateToHMM()).bold() + Text(" and ") + Text(interval.addMinutesToDate(minutesToAdd: 30).simplifyDateToTimeString()).bold() + Text("!")
            })
        }
    }
}

struct SimpleBedtimeBarChart_Previews: PreviewProvider {
    static var previews: some View {
        SimpleBedtimeBarChart(experiment: SleepExperiment.bedtimeSampleExperiment2, dependentVariable: .productivity)
    }
}
