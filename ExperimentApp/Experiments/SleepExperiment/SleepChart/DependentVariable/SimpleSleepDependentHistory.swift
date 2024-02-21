//
//  SimpleSleepDependentHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI
import Charts
struct SimpleSleepDependentHistory: View {
    
    let experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable = .both
    @State var barChartEntries: [BarChartEntry] = []
   
    struct BarChartEntry: Identifiable{
       
        let id: UUID
        let value: Int
        let missing: Bool
        let index: String
        
        init(id: UUID = UUID(), value: Int, index: Int) {
            self.id = id
            self.value = value
            self.missing = false
            switch(index){
            case 0: self.index = ".one"
            case 1: self.index = ".two"
            case 2: self.index = ".three"
            case 3: self.index = ".four"
            case 4: self.index =  "five"
            case 5: self.index =  "six"
            case 6: self.index =  "seeven"
            default: self.index = "one"
            }
        }
        init(id: UUID = UUID(), index: Int, missingValue: Int = 1){
            self.id = id
            self.value = missingValue
            self.missing = true
            switch(index){
            case 0: self.index = ".one"
            case 1: self.index = ".two"
            case 2: self.index = ".three"
            case 3: self.index = ".four"
            case 4: self.index =  "five"
            case 5: self.index =  "six"
            case 6: self.index =  "seeven"
            default: self.index = "one"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                getIcon()
                getMessage()
            }

            Chart(barChartEntries){ entry in
                BarMark(
                    x: .value("Date", entry.index),
                    yStart: .value("Min", 0),
                    yEnd: .value("Bedtime", entry.value)
                ).foregroundStyle(entry.missing ? .gray: .red)
            }.onAppear(perform: prepareBarChartEntries)
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
            .frame(height: 120)
        }
    }
    func prepareBarChartEntries(){
        let lastEntries = experiment.entries.suffix(7)
        let count = lastEntries.count
        let missingEntries = 7-count
        var index = 0
        for _ in 0..<missingEntries{
            barChartEntries.append(BarChartEntry(index: index))
            index+=1
        }
        for entry in lastEntries {
            barChartEntries.append(BarChartEntry(value: getEntryValue(entry: entry), index: index))
            index+=1
        }
        if(index > 7){
            print("something broke")
        }
    }
    
    func getMessage() -> AnyView{
        if(experiment.dependentVariable == .quality || dependentVariable == .quality){
            return AnyView(Text("In your last 7 entries, the average quality of your day was ") + Text("\(getAverage(entries: experiment.entries.suffix(7)))").bold())
        }
        return AnyView(Text("In your last 7 entries, your average productivity was ") + Text("\(getAverage(entries: experiment.entries.suffix(7)))").bold())
    }
    func getIcon() -> AnyView{
        if(experiment.dependentVariable == .quality || dependentVariable == .quality){
            return AnyView(Image(systemName: "sun.max"))
        }
        return AnyView(Image(systemName:"gearshape.2.fill"))
    }
    
    func getAverage(entries: [SleepEntry]) -> String{
        var sum = 0
        for entry in entries{
            sum += getEntryValue(entry: entry)
        }
        return "\(((Double)(sum)/(Double)(7) * pow(10, Double(2))).rounded() / pow(10, Double(2)))"
    }
    func getEntryValue(entry: SleepEntry) -> Int{
        if(experiment.dependentVariable == .quality || dependentVariable == .quality){
            return entry.quality
        }
        return entry.productivity
    }
    
    
}

struct SimpleSleepDependentHistory_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSleepDependentHistory(experiment: SleepExperiment.bedtimeSampleExperiment, dependentVariable: .quality)
    }
}
