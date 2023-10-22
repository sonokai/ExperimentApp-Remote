//
//  SleepExperiment.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/3/23.
//

import Foundation

struct SleepExperiment: Identifiable, Codable{
    let id: UUID
    let goalEntries: Int //ask user how many entries they want to have
    let dependentVariable: DependentVariable //ask user if they want to track how sleep affects their productivity or quality of day
    let independentVariable: IndependentVariable //ask user if they want to guess how much hours they slept on their own or only track bedtime, waketime, or both bedtime and waketime for the maximum data
    var entries: [SleepEntry] = []
    var notes: String = "Take notes here"
    var name: String = "Sleep Experiment"
    
    
    init(id: UUID = UUID(), goalEntries: Int, dependentVariable: DependentVariable, independentVariable: IndependentVariable) {
        self.id = id
        self.goalEntries = goalEntries
        self.dependentVariable = dependentVariable
        self.independentVariable = independentVariable
    }
    //for testing
    init(id: UUID = UUID(), goalEntries: Int, dependentVariable: DependentVariable, independentVariable: IndependentVariable, entries: [SleepEntry], name: String, notes: String) {
        self.id = id
        self.goalEntries = goalEntries
        self.dependentVariable = dependentVariable
        self.independentVariable = independentVariable
        self.entries = entries
        self.name = name
        self.notes = notes
    }
    
}
extension SleepExperiment{
    enum DependentVariable: String, Codable, CaseIterable, Identifiable{
        var id: Self{
            return self
        }
        case productivity = "productivity"
        case quality = "quality"
        case both = "both"
        
        var name: String {
            rawValue.capitalized
        }
    }
    enum IndependentVariable: String, Codable, CaseIterable, Identifiable{
        var id: Self {
            
            return self
        }
        
        
        
        case bedtime = "bedtime"
        case waketime = "waketime"
        case both = "both"
        case hoursSlept = "hours slept"
        
        var name: String {
            rawValue.capitalized
        }
    }
}

extension SleepExperiment{
    static let emptyExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime)
    
    static let bedtimeSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime, entries: SleepEntry.sampleData, name: "Sleep Experiment 1", notes: "notes")
    
    static let bothTimesSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .both, entries: sampleDataForExperiment2, name: "Sleep Experiment 2", notes: "notes")
    
    static let sampleDataForExperiment2: [SleepEntry] =
    [
        
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!,
                   quality: 5,
                   productivity: 5),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date())!,
                   quality: 6,
                   productivity: 7),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 10, minute: 48, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 9, minute: 40, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 21, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 10, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        
    ]
    
    static let bedtimebothExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .bedtime, entries:sampleData12, name: "", notes: "")
    static let sampleData12: [SleepEntry] = [
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 10, minute: 48, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!,
                   quality: 8,
                   productivity: 9),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 20, second: 0, of: Date())!,
                   quality: 9,
                   productivity: 10)
    ]
    static let hoursSleptSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .hoursSlept, entries: sampleDataForExperiment3, name: "Sleep Experiment 3", notes: "notes")
    
    static let sampleDataForExperiment3: [SleepEntry] =
    [
        
        SleepEntry(date: Date(),
                   quality: 5,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 30),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 7,
                   hoursSlept: 11, minutesSlept: 30),
        SleepEntry(date: Date(),
                   quality: 7,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 40),
        SleepEntry(date: Date(),
                   quality: 3,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 20),
        SleepEntry(date: Date(),
                   quality: 4,
                   productivity: 8,
                   hoursSlept: 11, minutesSlept: 15),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 9,
                   hoursSlept: 10, minutesSlept: 55),
        SleepEntry(date: Date(),
                   quality: 3,
                   productivity: 10,
                   hoursSlept: 10, minutesSlept: 45),
        SleepEntry(date: Date(),
                   quality: 5,
                   productivity: 8,
                   hoursSlept: 11, minutesSlept: 20),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 7,
                   hoursSlept: 10, minutesSlept: 40),
        SleepEntry(date: Date(),
                   quality: 5,
                   productivity: 7,
                   hoursSlept: 10, minutesSlept: 0),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 10,
                   hoursSlept: 11, minutesSlept: 30),
        SleepEntry(date: Date(),
                   quality: 7,
                   productivity: 9,
                   hoursSlept: 12, minutesSlept: 30)
        
    ]
    
    static let experimentArray: [SleepExperiment] = [
    bedtimeSampleExperiment, bothTimesSampleExperiment, hoursSleptSampleExperiment
    ]
    func getTitle() -> String{
        var string1 = ""
        switch(self.independentVariable){
            case .bedtime: string1 = "Bedtime"
            case .waketime: string1 = "Wake time"
            case .both: string1 = "Both Bedtime and Waketime"
            case .hoursSlept: string1 = "Hours slept "
        }
        var string2 = ""
        switch(self.dependentVariable){
            case .quality: string2 = "Quality of day"
            case .productivity: string2 = "Productivity"
            case .both: string2 = "Quality of day and Productivity"
        }
        
        return string1 + " vs. " + string2
    }
    
    
}

// bedtime stats
extension SleepExperiment{
    //returns the best time to sleep
    func getOptimalBedtimeInterval(size: Int) -> Date?{
        if(independentVariable != .bedtime){
            print("Wrong method loser")
            return nil
        }
        let least = getLeastBedtimeMinutes()
        let most = getMostBedtimeMinutes()
        
        var optimalIntervalAverage: Double = 0
        var optimalInterval = least
        
        for i in least..<(most-size){
            if(averageOfInterval(at: i, for: size) > optimalIntervalAverage){
                optimalIntervalAverage = averageOfInterval(at: i, for: size)
              //  print("Optimal interval detected at: \(optimalInterval). New highest average interval: \(averageOfInterval(at: i, for: size))")
                optimalInterval = i
            }
            print("i = \(i)")
        }
        //convert i back into date
        
        return Calendar.current.date(bySettingHour: optimalInterval/60, minute: optimalInterval % 60, second: 0, of: Date())
    }
    
    static func getHoursAndMinute(from date: Date) -> (Int, Int){
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        guard let hour = components.hour else {
            fatalError("Failed to extract")
        }
        let calendar1 = Calendar.current
        let components1 = calendar1.dateComponents([.minute], from: date)
        guard let minute = components1.minute else {
            fatalError("Failed to extract")
        }
        return (hour, minute)
    }
    
    static func getMinutes(from date: Date)-> Int {
        let time = getHoursAndMinute(from: date)
        return time.0*60+time.1
    }
    
    func getLeastBedtimeMinutes() -> Int{
        var least = 100000000
        for entry in entries{
            let minutes = SleepExperiment.getMinutes(from: entry.bedtime)
            if(minutes < least){
                least = minutes
            }
        }
        return least
    }
    func getMostBedtimeMinutes() -> Int{
        var most = 0
        for entry in entries{
            let minutes = SleepExperiment.getMinutes(from: entry.bedtime)
            if(minutes > most){
                most = minutes
            }
        }
        return most
    }
    
    
    //wait do i care about efficiency?
    func averageOfInterval(at startingMinutes: Int, for size: Int) -> Double{
        var sum = 0
        var count = 0
        for entry in entries{
            let minutes = SleepExperiment.getMinutes(from: entry.bedtime)
            if(minutes >= startingMinutes && minutes < startingMinutes + size){
                sum += entry.quality
                count += 1
            }
            
        }
      //  print("sum: \(sum)")
       // print("count: \(count)")
        if(count == 0){
            return 0
        }
        return (Double)(sum)/(Double)(count)
    }
    
    
}
