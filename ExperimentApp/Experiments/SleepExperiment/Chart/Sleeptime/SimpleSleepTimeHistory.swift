//
//  SimpleSleepTimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct SimpleSleepTimeHistory: View {
    var experiment: SleepExperiment
    var body: some View {
        VStack(alignment: .leading){
            
            
            
            HStack{
                Image(systemName: "bed.double")
                //in the time of your last entry, you slept <minutes> <later or earlier> than normal
                SleepTimeHistoryMessage(experiment: experiment)
            }
            Chart(getLast7Entries()){ entry in
                BarMark(
                    x: .value("Date", entry.date.convertToMMDDYYYY(), unit: .day),
                    yStart: .value("Min", getYDomain().lowerBound),
                    yEnd: .value("Bedtime",SleepExperiment.getSleepTimeSeconds(from: entry))
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
    func getYDomain() -> ClosedRange<Double>{
        let (least, most) = getSleepTimeRange()
        let tickSize = getYAxisTickSize()
        let startTicks = Double(floor(least/tickSize))
        let endTicks = Double(floor(most/tickSize))
        return (startTicks*tickSize-getYAxisTickSize()...endTicks*tickSize+getYAxisTickSize())
    }
    func getYAxisTickSize() -> Double{
        //want: 4 marks per chart at least
        let (least, most) = getSleepTimeRange()
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
    func getSleepTimeRange() -> (Double, Double){
        var least = (Double)(0)
        var most = (Double)(0)
        for entry in experiment.entries{
            let seconds = Double(getSleepTimeSeconds(from: entry))
            
            if(seconds < least || least == 0){
                least = seconds
            }
            if(seconds > most){
                most = seconds
            }
        }
        
        return (least, most)
    }
    func getSleepTimeSeconds(from entry: SleepEntry)-> Int{
        return entry.hoursSlept*3600 + entry.minutesSlept*60
    }
    
}

struct SimpleSleepTimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSleepTimeHistory(experiment: SleepExperiment.hoursSleptSampleExperiment)
    }
}
