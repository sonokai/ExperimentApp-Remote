//
//  BedtimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/14/23.
//

import SwiftUI
import Charts
//this crashes if you get two of the same date
struct BedtimeHistory: View {
    var experiment: SleepExperiment
    @State var showFullRange = false
    var body: some View {
        VStack(alignment: .leading){
            Text("Bedtimes")
            Chart(experiment.entries){ entry in
                PointMark(
                    x: .value("Date", convertToDate(entry.date), unit: .day),
                    y: .value("Bedtime", convertBedtime(entry: entry))
                ).foregroundStyle(.red)
            }.frame(height: 300)
                .chartYAxis {
                    AxisMarks(values: .stride(by: getYAxisTickSize())) { value in
                        AxisGridLine()
                        
                        if let value = value.as(Double.self) {
                            AxisValueLabel {
                                Text(simplifySecondsToTimeString(value))
                            }
                        }
                    }
                }
                .chartYScale(domain: getYDomain())
                .chartXAxis{
                    AxisMarks(values: .stride(by: .day, count: getXAxisTickSize())){ value in
                        if(xValueInRange(date: value.as(Date.self))){
                            AxisValueLabel()
                            AxisGridLine()
                            AxisTick()
                        }else {
                            AxisGridLine()
                            AxisTick()
                        }
                    }
                }
                .chartXScale(domain: getXDomain())
                
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
    func getEntryRange() -> (Date, Date){
        return (experiment.entries[0].date, experiment.entries[experiment.entries.count-1].date)
    }
    //returns the number of days to stride by, assuming the total range is less than 3 months
    func getXAxisTickSize() -> Int{
        let (startDate, endDate) = getEntryRange()
        let difference = endDate.timeIntervalSince(startDate)
        let daysDifference = difference / 86_400
        if(daysDifference >= 21){
            return 7
        }
        if(daysDifference >= 9){
            return 3
        }
        if(daysDifference >= 6){
            return 2
        }
        return 1
    }
    func getXDomain() -> ClosedRange<Date>{
        let (startDate, endDate) = getEntryRange()
        let difference = endDate.timeIntervalSince(startDate)
        let daysDifference = difference / 86_400
        let tickSize = getXAxisTickSize()
        var totalTicks = daysDifference / Double(tickSize)
        totalTicks = totalTicks+1
        let timeToAdd = floor(totalTicks) * Double(tickSize) * 86_400
        return (startDate...startDate.addingTimeInterval(timeToAdd))
    }
    func simplifySecondsToTimeString(_ seconds: Double) -> String{
        let date = Date(timeIntervalSince1970: seconds)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:mm a"
        let dateString = dateformatter.string(from: date)
        return dateString
    }
    func xValueInRange(date: Date?) -> Bool{
        let (_, endDate) = getEntryRange()
        if let date1 = date{
            if(date1.timeIntervalSince1970>endDate.timeIntervalSince1970){
                return false
            }
        }
        return true
    }
}

struct BedtimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeHistory(experiment: SleepExperiment.midnightSampleExperiment).padding()
    }
}
