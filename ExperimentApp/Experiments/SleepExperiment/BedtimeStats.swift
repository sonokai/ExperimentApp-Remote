//
//  SleepStats.swift
//  ExperimentApp
//
//  Created by Bell Chen on 10/19/23.
//

import SwiftUI

struct BedtimeStats: View {
    var experiment: SleepExperiment
    @State var showRange = false
    @State var interval : Date = Date()
    @State var size: Int = 15
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality
    
    var body: some View {
        
        Form{
            Section("Chart"){
                BedtimeChart(experiment: experiment, interval: interval, size: size, showRange: showRange, dependentVariable: $dependentVariable)
            }.onAppear(){
                if(experiment.dependentVariable == .quality){
                    dependentVariable = .quality
                }
                if(experiment.dependentVariable == .productivity){
                    dependentVariable = .productivity
                }
            }.onChange(of: dependentVariable){ _ in
                updateInterval()
            }
            Section("Settings"){
                Toggle("Show optimal interval", isOn: $showRange)
                if(showRange){
                    HStack{
                        Text("Optimal interval:")
                        Spacer()
                        Text("\(convertDate(from: interval)) - \(addMinutesToDate(date: interval, minutesToAdd: size))")
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
                    SliderView(name: "Interval size (minutes)",value: $size, lowValue: 5, highValue: 30 > experiment.getBedtimeRange() ?  (Double)(experiment.getBedtimeRange()) : 30)
                        .onChange(of: size){ _ in
                        updateInterval()
                    }.onAppear(){
                        updateInterval()
                    }.disabled(experiment.getBedtimeRange()<5)
                    if(experiment.getBedtimeRange()<5){
                        Text("You need more data!")
                    }
                }
            }
            Section("Stats"){
                HStack{
                    Text("Average bedtime: ")
                    Spacer()
                    Text("\(experiment.getAverageBedtime())")
                }
                HStack{
                    Text("Median bedtime: ")
                    Spacer()
                    Text("\(experiment.getMedianBedtime())")
                }
                if(dependentVariable == .quality){
                    HStack{
                        Text("Average quality of day: ")
                        Spacer()
                        Text("\(experiment.getAverageQuality())")
                    }
                } else{
                    HStack{
                        Text("Average productivity: ")
                        Spacer()
                        Text("\(experiment.getAverageProductivity())")
                    }
                }
                
                
            }
            
        }
        
    }
    func updateInterval(){
        if let tempinterval =
            experiment.getOptimalBedtimeInterval(size: size, dependentVariable: dependentVariable){
            interval = tempinterval
        } else {
            interval = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        }
    }
    func convertDate(from date: Date) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:mm a"
        let dateString = dateformatter.string(from: date)
        return dateString
    }
    func addMinutesToDate(date: Date, minutesToAdd: Int) -> String {
        let calendar = Calendar.current
        let updatedDate = calendar.date(byAdding: .minute, value: minutesToAdd, to: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: updatedDate ?? date)
    }
    func calculateAverage()-> String{
        let average = experiment.averageOfBedtimeInterval(at: SleepExperiment.getMinutes(from: interval), for: size, dependentVariable: dependentVariable)
        var hundredths = Int(average*100)
        let ones = hundredths / 100
        hundredths = hundredths % 100
        if(hundredths == 0){
            return "\(ones)"
        }
        return "\(ones).\(hundredths)"
    }
}

struct SleepStats_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeStats(experiment: SleepExperiment.bedtimeSampleExperiment3)
    }
}
