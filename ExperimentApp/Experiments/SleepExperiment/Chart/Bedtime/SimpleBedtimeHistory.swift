//
//  SimpleBedtimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/14/23.
//

import SwiftUI
import Charts
struct SimpleBedtimeHistory: View {
    var experiment: SleepExperiment
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Image(systemName: "bed.double")
                Text("Last week, you slept ") + Text("23 minutes").bold() + Text(" later than normal")
            }
            Chart(experiment.entries){ entry in
                BarMark(
                    x: .value("Date", convertToDate(entry.date), unit: .day),
                    yStart: .value("Min", getYDomain().lowerBound),
                    yEnd: .value("Bedtime", convertBedtime(entry: entry))
                ).foregroundStyle(.red)
            }
            .chartYAxis {
                AxisMarks(values: .stride(by: getYAxisTickSize())) { value in
                    
                }
            }
            .chartYScale(domain: getYDomain())
            
            .chartXAxis{
                AxisMarks(){
                    
                }
            }.frame(height: 120)
            
            
            
        }
    }
    func convertToDate(_ date: Date) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy"
        
        if let convertedDate = dateFormatter.date(from: dateFormatter.string(from: date)) {
            return convertedDate
        } else {
            print("COULDNT CONVERT DATE")
            return Date()
        }
    }
    func convertBedtime(entry: SleepEntry) -> Double{
        let seconds = entry.bedtime.timeIntervalSince1970.truncatingRemainder(dividingBy: 86_400)
        //if am, pass it at the next day
        if(seconds<43_200){
            return seconds + 86_400
        }
        return seconds
    }
    func getBedtimeRange() -> (Double, Double){
        var least = (Double)(0)
        var most = (Double)(0)
        for entry in experiment.entries{
            
            var seconds = entry.bedtime.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)
            if(seconds<43_200){
                seconds += 86_400
            }
            
            if(seconds < least || least == 0){
                least = seconds
            }
            if(seconds > most){
                most = seconds
            }
        }
        return (least, most)
    }
    //returns the yDomain
    func getYDomain() -> ClosedRange<Double>{
        let (least, most) = getBedtimeRange()
        let startHour = Double(floor(least/3600))
        let endHour = Double(floor(most/3600))
        return (startHour*3600-getYAxisTickSize()...endHour*3600+getYAxisTickSize())
    }
    //returns seconds to stride the y axis by
    func getYAxisTickSize() -> Double{
        //want: 4 marks per chart at least
        let (least, most) = getBedtimeRange()
        let startHour = Double(floor(least/3600))
        let endHour = Double(floor(most/3600))
        let difference = endHour - startHour + 2
        if(difference > 16){
            return 14_400
        }
        if(difference > 8){
            return 7_200
        }
        if(difference > 4){
            return 3_600
        }
        if(difference > 2){
            return 1_800
        }
        return 900
    }
    func simplifySecondsToTimeString(_ seconds: Double) -> String{
        let date = Date(timeIntervalSince1970: seconds)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:mm a"
        let dateString = dateformatter.string(from: date)
        return dateString
    }
}


struct SimpleBedtimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        SimpleBedtimeHistory(experiment: SleepExperiment.midnightSampleExperiment).padding()
    }
}
