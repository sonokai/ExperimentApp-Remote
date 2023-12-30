//
//  SimpleWaketimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct SimpleWaketimeHistory: View {
    var experiment: SleepExperiment
    var body: some View {
        VStack(alignment: .leading){
            
            
            
            HStack{
                Image(systemName: "bed.double")
                //in the time of your last entry, you slept <minutes> <later or earlier> than normal
                WaketimeHistoryMessage(experiment: experiment)
            }
            Chart(getLast7Entries()){ entry in
                BarMark(
                    x: .value("Date", entry.date.convertToMMDDYYYY(), unit: .day),
                    yStart: .value("Min", getYDomain().lowerBound),
                    yEnd: .value("Bedtime",SleepExperiment.getWaketimeSeconds(from: entry.waketime))
                ).foregroundStyle(.orange)
            }
            .chartYAxis(.hidden)
            .chartYScale(domain: getYDomain())
            .chartXAxis(.hidden)
            .frame(height: 120)
        }
    }
    func getLast7Entries() -> [SleepEntry]{
        if(experiment.entries.count<7){
            print("Called simplebedtimehistory but count was less than 7")
            return experiment.entries
        }
        return experiment.entries.suffix(7)
    }
    
    func getWaketimeRange() -> (Double, Double){
        var least = (Double)(0)
        var most = (Double)(0)
        for entry in experiment.entries{
            
            var seconds = entry.waketime.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)
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
    
    func getYDomain() -> ClosedRange<Double>{
        let (least, most) = getWaketimeRange()
        let tickSize = getYAxisTickSize()
        let startTicks = Double(floor(least/tickSize))
        let endTicks = Double(floor(most/tickSize))
        return (startTicks*tickSize-getYAxisTickSize()...endTicks*tickSize+getYAxisTickSize())
    }
    //returns seconds to stride the y axis by
    func getYAxisTickSize() -> Double{
        //want: 4 marks per chart at least
        let (least, most) = getWaketimeRange()
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
    
    //returns the number of days to stride by, assuming the total range is less than 3 months
    func getXAxisTickSize() -> Int{
        let (startDate, endDate) = experiment.getDateRange()
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
        let (startDate, endDate) = experiment.getDateRange()
        let difference = endDate.timeIntervalSince(startDate) //assumes
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
    

}

struct SimpleWaketimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        SimpleWaketimeHistory(experiment: SleepExperiment.waketimeSampleExperiment).padding()
    }
}
