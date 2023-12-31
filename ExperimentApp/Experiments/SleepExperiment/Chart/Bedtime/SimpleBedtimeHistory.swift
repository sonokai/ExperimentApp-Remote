//
//  SimpleBedtimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/14/23.
//

import SwiftUI
import Charts
//Required: 7 entries
struct SimpleBedtimeHistory: View {
    var experiment: SleepExperiment
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            
            HStack{
                Image(systemName: "bed.double")
                //in the time of your last entry, you slept <minutes> <later or earlier> than normal
                BedtimeHistoryMessage(experiment: experiment)
            }
            Chart(getLast7Entries()){ entry in
                BarMark(
                    x: .value("Date", entry.date.convertToMMDDYYYY(), unit: .day),
                    yStart: .value("Min", getYDomain().lowerBound),
                    yEnd: .value("Bedtime",SleepExperiment.getBedtimeSeconds(from: entry.bedtime))
                ).foregroundStyle(.red)
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
        let tickSize = getYAxisTickSize()
        let startTicks = Double(floor(least/tickSize))
        let endTicks = Double(floor(most/tickSize))
        return (startTicks*tickSize-getYAxisTickSize()...endTicks*tickSize+getYAxisTickSize())
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
    static var sample = SleepExperiment(goalEntries: 50, dependentVariable: .productivity, independentVariable: .bedtime, entries: [SleepEntry(date: Date(), bedtime: Date(), quality: 3)], name: "", notes: "")
    static var previews: some View {
        SimpleBedtimeHistory(experiment: SleepExperiment.midnightSampleExperiment).padding()
    }
}
