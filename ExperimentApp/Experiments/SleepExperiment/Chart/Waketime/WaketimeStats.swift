//
//  WaketimeStats.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/2/23.
//

import SwiftUI

struct WaketimeStats: View {
    var experiment: SleepExperiment
    @State var showRange = false
    @State var interval : Date = Date()
    @State var size: Int = 15
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality
    var body: some View {
        Form{
            Section("Chart"){
                WaketimeChart(experiment: experiment, interval: interval, size: size, showRange: showRange, dependentVariable: $dependentVariable)
                
            }.onAppear(){
                if(experiment.dependentVariable == .quality){
                    dependentVariable = .quality
                }
                if(experiment.dependentVariable == .productivity){
                    dependentVariable = .productivity
                }
            }.onChange(of: dependentVariable){ _ in
                updateOptimalInterval()
            }
            Section("Settings"){
                Toggle("Show optimal interval", isOn: $showRange)
                if(showRange){
                    HStack{
                        Text("Optimal interval:")
                        Spacer()
                        Text("\(interval.simplifyDateToTimeString()) - \(interval.addMinutesToDate(minutesToAdd: size).simplifyDateToTimeString())")
                    }
                    HStack{
                        if(dependentVariable == .quality){
                            Text("Average quality of day: ")
                        } else{
                            Text("Average productivity: ")
                        }
                        Spacer()
                        Text("\(calculateAverage())")
                    }
                    SliderView(name: "Interval size (minutes)",value: $size, lowValue: 5, highValue: 30 > experiment.getWaketimeRange() ?  (Double)(experiment.getWaketimeRange()) : 30)
                    .onChange(of: size){ _ in
                        updateOptimalInterval()
                    }.onAppear(){
                        updateOptimalInterval()
                    }.disabled(experiment.getWaketimeRange()<5 || experiment.entries.count == 0)
                    if(experiment.getWaketimeRange()<5){
                        Text("You need more data!")
                    }
                    
                }
            }
            Section("Stats"){
                HStack{
                    Text("Average waketime: ")
                    Spacer()
                    Text("\(experiment.getAverageWaketime())")
                }
                HStack{
                    Text("Median waketime:")
                    Spacer()
                    Text("\(experiment.getMedianWaketime())")
                }
                if(dependentVariable == .quality){
                    HStack{
                        Text("Average quality of day: ")
                        Spacer()
                        Text("\(experiment.getAverageQuality())")
                    }
                }
                if(dependentVariable == .productivity){
                    HStack{
                        Text("Average productivity: ")
                        Spacer()
                        Text("\(experiment.getAverageProductivity())")
                    }
                }
            }
        }
    }
    
    
    //returns the average of the dependent variable within the optimal interval
    func calculateAverage()-> String{
        let average = experiment.averageOfWaketimeInterval(at: SleepExperiment.getMinutes(from: interval), for: size, dependentVariable: dependentVariable)
        var hundredths = Int(average*100)
        let ones = hundredths / 100
        hundredths = hundredths % 100
        if(hundredths == 0){
            return "\(ones)"
        }
        return "\(ones).\(hundredths)"
    }
    func updateOptimalInterval(){
        if let ainterval = experiment.getOptimalWaketimeInterval(size: size, dependentVariable: dependentVariable){
            interval = ainterval
        } else {
            interval = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        }
    }
}

struct WaketimeStats_Previews: PreviewProvider {
    static var previews: some View {
        WaketimeStats(experiment: SleepExperiment.waketimeSampleExperiment2)
    }
}
