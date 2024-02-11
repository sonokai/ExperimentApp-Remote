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
    @State var barChartEntries: [SimpleSleepDependentHistory.BarChartEntry] = []
    enum Day: String, Identifiable{
        var id: Self{
            return self
        }
        case one = "one"
        case two  = "two"
        case three = "three"
        case four = "four"
        case five = "five"
        case six = "six"
        case seven = "seven"
    }
    var body: some View {
        VStack(alignment: .leading){
            
            
            
            HStack{
                Image(systemName: "bed.double")
                //in the time of your last entry, you slept <minutes> <later or earlier> than normal
                if(experiment.entries.count == 0){
                    Text("Add more entries to analyze your time slept")
                }else {
                    SleepTimeHistoryMessage(experiment: experiment)
                }
               
            }
            if(experiment.entries.count == 0){
                EmptyChart()
            } else {
                Chart(barChartEntries){ entry in
                    BarMark(
                        x: .value("Date", entry.index),
                        yStart: .value("Min", (Int)(getYDomain().lowerBound)),
                        yEnd: .value("Waketime", entry.value)
                    ).foregroundStyle(entry.missing ? .gray: .purple)
                }.onAppear(perform: prepareBarChartEntries)
                    .chartYAxis(.hidden)
                    .chartYScale(domain: getYDomain())
                    .chartXAxis(.hidden)
                    .frame(height: 120)
            }
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
    func getIndex(of entry: SleepEntry) -> Day{
        if let index = experiment.entries.firstIndex(where: { $0.id == entry.id }) {
            switch(index%7){
            case 0: return .one
            case 1: return .two
            case 2: return .three
            case 3: return .four
            case 4: return .five
            case 5: return .six
            case 6: return .seven
            default: return .one
            }
            
        } else {
            return .one
        }
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
    
    func prepareBarChartEntries(){
        let lastEntries = experiment.entries.suffix(7)
        let count = lastEntries.count
        let missingEntries = 7-count
        var index = 0
        for _ in 0..<missingEntries{
            barChartEntries.append(SimpleSleepDependentHistory.BarChartEntry(index: index, missingValue: (Int)(experiment.getAverageSleepTimeAsSeconds())))
            index+=1
        }
        for entry in lastEntries {
            barChartEntries.append(SimpleSleepDependentHistory.BarChartEntry(value:     (Int)(SleepExperiment.getSleepTimeSeconds(from: entry)), index: index))
            index+=1
        }
        if(index > 7){
            print("something broke")
        }
    }
    
}

struct SimpleSleepTimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSleepTimeHistory(experiment: SleepExperiment.hoursSleptSampleExperiment)
    }
}
