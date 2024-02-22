//
//  SimpleBedtimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/14/23.
//

import SwiftUI
import Charts
//doesn't require 7 entries but if there isn't 7 entries will fill in
//with gray bars
struct SimpleBedtimeHistory: View {
    var experiment: SleepExperiment
    @State var barChartEntries: [SimpleSleepDependentHistory.BarChartEntry] = []
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            
            HStack(){
                Image(systemName: "bed.double")
                //in the time of your last entry, you slept <minutes> <later or earlier> than normal
                if(experiment.entries.count == 0){
                    Text("Add some entries to see bedtime data")
                } else {
                    BedtimeHistoryMessage(experiment: experiment)
                }
            }
            Spacer()
            if(experiment.entries.count == 0){
                EmptyChart()
            } else {
                Chart(barChartEntries){ entry in
                    BarMark(
                        x: .value("Date", entry.index),
                        yStart: .value("Min", (Int)(getYDomain().lowerBound)),
                        yEnd: .value("Bedtime", entry.value)
                    ).foregroundStyle(entry.missing ? .gray: .red)
                }.onAppear(perform: prepareBarChartEntries)
                    .chartYAxis(.hidden)
                    .chartXAxis(.hidden)
                    .chartYScale(domain: getYDomain())
                    .frame(height: 120)
                    .onAppear(){
                        prepareBarChartEntries()
                    }
            }
        }.frame(height: 180)
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
        for entry in getLast7Entries(){
            let seconds = SleepExperiment.getBedtimeSeconds(from: entry.bedtime)
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
    func prepareBarChartEntries(){
        barChartEntries = []
        let lastEntries = experiment.entries.suffix(7)
        let count = lastEntries.count
        let missingEntries = 7-count
        var index = 0
        for _ in 0..<missingEntries{
            barChartEntries.append(SimpleSleepDependentHistory.BarChartEntry(index: index, missingValue: (Int)(experiment.getAverageBedtimeAsSeconds())))
            index+=1
        }
        for entry in lastEntries {
            barChartEntries.append(SimpleSleepDependentHistory.BarChartEntry(value:     (Int)(SleepExperiment.getBedtimeSeconds(from: entry.bedtime)), index: index))
            index+=1
        }
        if(index > 7){
            print("something broke")
        }
    }
    
}


struct SimpleBedtimeHistory_Previews: PreviewProvider {
    static var sample = SleepExperiment(goalEntries: 50, dependentVariable: .productivity, independentVariable: .bedtime, entries: [SleepEntry(date: Date(), bedtime: Date(), quality: 3)], name: "")
    static var previews: some View {
        SimpleBedtimeHistory(experiment: SleepExperiment.bedtimeShortExperiment).padding()
    }
}
