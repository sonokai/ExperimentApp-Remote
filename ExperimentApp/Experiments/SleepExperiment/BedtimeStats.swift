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
    
    var body: some View {
        
        Form{
            Section("Chart"){
                BedtimeChart(experiment: experiment, interval: interval, size: size, showRange: showRange)
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
                        Text("Average quality of day: ")
                        Spacer()
                        Text("\(calculateAverage())")
                    }
                    SliderView(name: "Interval size (minutes)",value: $size, lowValue: 5, highValue: 30)
                        .onChange(of: size){ _ in
                        if let ainterval = experiment.getOptimalBedtimeInterval(size: size){
                            interval = ainterval
                        } else {
                            interval = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
                        }
                    }.onAppear(){
                        if let ainterval = experiment.getOptimalBedtimeInterval(size: size){
                            interval = ainterval
                        } else {
                            interval = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
                        }
                    }
                }
            }
            Section("Stats"){
                Text("Average bedtime: ")
            }
            
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
        let average = experiment.averageOfInterval(at: SleepExperiment.getMinutes(from: interval), for: size)
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
        BedtimeStats(experiment: SleepExperiment.bedtimeSampleExperiment)
    }
}
