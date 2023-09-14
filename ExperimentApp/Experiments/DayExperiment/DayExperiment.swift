//
//  DayExperiment.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/26/23.
//

import Foundation

struct DayExperiment: Identifiable, Codable{
    let id: UUID
    let goalEntries: Int //ask user how many entries they want to have
    let independentVariable: IndependentVariable
    let dependentVariable: DependentVariable
    var entries: [DayEntry] = []
    var notes: String = "Take notes here"
    var name: String = "Time of day Experiment"
    
    
    
    
    init(id: UUID = UUID(), goalEntries: Int, independentVariable: IndependentVariable, dependentVariable: DependentVariable) {
        self.id = id
        self.goalEntries = goalEntries
        self.independentVariable = independentVariable
        self.dependentVariable = dependentVariable
    }
    //for testing
    init(id: UUID = UUID(), goalEntries: Int, independentVariable: IndependentVariable, dependentVariable: DependentVariable, entries: [DayEntry], name: String, notes: String) {
        self.id = id
        self.goalEntries = goalEntries
        self.independentVariable = independentVariable
        self.dependentVariable = dependentVariable
        self.entries = entries
        self.name = name
        self.notes = notes
    }
    
}


extension DayExperiment{
    enum DependentVariable: String, CaseIterable, Codable, Identifiable{
        var id: Self{
            return self
        }
        case plannedToDoneRatio = "Ratio"
        case focus = "Focus"
        case time = "Time"
        
        var name: String{
            rawValue
        }
    }
      
    static let timeArray: [String] = ["Morning, Afternoon, Evening"]
    
    enum Time: String, CaseIterable, Identifiable, Codable{
        case morning = "Morning"
        case afternoon = "Afternoon"
        case evening = "Evening"
        
        var id: String {
            rawValue
        }
    }
    
    struct IndependentVariable: Identifiable, Codable{
        
        
        let id: UUID
        var timesOfDay: [timeOfDay] = []
        
        init(id: UUID = UUID(), timesOfDay: [timeOfDay]){
            self.id = id
            self.timesOfDay = timesOfDay
        }
        
        struct timeOfDay: Identifiable, Codable, Hashable{
            
            
            let id: UUID
            let name: String
            init(id: UUID = UUID(), name: String) {
                self.id = id
                self.name = name
            }
        }
        
        ///returns whether or not the times is empty
        func timesOfDayIsEmpty() -> Bool{
            return timesOfDay.count == 0
        }
        
        func containsTime(time: String) -> Bool{
            for timeOfDay in timesOfDay{
                if(timeOfDay.name == time){
                    return true
                }
            }
            return false
        }
        ///looks through time array to see if a time with a given string is present, if yes, then it removes it. If not, prints a message saying it failed to find the time
        mutating func removeTime(time: String) {
            for index in 0..<timesOfDay.count{
                if(timesOfDay[index].name == time){
                    timesOfDay.remove(at: index)
                    print("Removed time: \(time)")
                    return
                }
            }
            
            print("Failed to find time: \(time)")
        }
        
        ///used in daySetupView to resolve an error where the default times showed up twice
        func findIndexesToAvoid()-> Set<Int>{
            var set: Set<Int> = []
            for index in 0..<timesOfDay.count{
                if(timesOfDay[index].name == "Afternoon" || timesOfDay[index].name == "Morning" || timesOfDay[index].name == "Evening"){
                    set.insert(index)
                }
            }
            return set
        }
        
    
        
    }
    
    
    //sample data
    static let sampleCustomTime1 = IndependentVariable.timeOfDay(name: "Before dinner")
    static let sampleCustomTime2 = IndependentVariable.timeOfDay(name: "After school")
    
    static let sampleCustomTimes = [
    IndependentVariable.timeOfDay(name: "Before dinner"),
    IndependentVariable.timeOfDay(name: "After school"),
    IndependentVariable.timeOfDay(name: "Morning"),
    IndependentVariable.timeOfDay(name: "Afternoon"),
    IndependentVariable.timeOfDay(name: "Evening")
    ]
    static let sampleIndependentVariable = IndependentVariable(timesOfDay: sampleCustomTimes)
    
    static let sampleExperiment: DayExperiment = DayExperiment(goalEntries: 50, independentVariable: sampleIndependentVariable,dependentVariable: .focus, entries:  DayEntry.sampleData, name: "Sample Day Experiment", notes: "yay")
    
    
    static let sampleExperimentArray: [DayExperiment] = [
    sampleExperiment, sampleExperiment
    ]
    
}

extension DayExperiment{
    //note that the dependent variables focus and minutesWorked are ints, and ratio is a double.
    func getAverageArray() -> [Double]{
        //this is the array that will be added to
        var averageArray: [Double] = []
        
        let timesOfDay = self.independentVariable.timesOfDay
        //first, iterate through all the times because we need to find the averages for all the times
        for index in 0..<timesOfDay.count{
            let timeName = timesOfDay[index].name
            
            
            //scan the entries array for entries with this time
            // then if it is the time being scanned, it adds its own value to the sum and adds it to the count
            var sum: Double = 0
            var count: Double = 0
            for entry in self.entries{
                //note that you cannot add ints to doubles, so for focus and minutes worked, we need to cast it to double
                if(entry.time == timeName){
                    count+=1
                    switch(self.dependentVariable){
                    case .focus:
                        sum += Double(entry.focus)
                    case .plannedToDoneRatio:
                        sum += entry.plannedToDoneRatio
                    case .time:
                        sum += Double(entry.minutesWorked)
                    
                    }
                }
            }
            //After scanning the entry array and adding everything all up, finish calculating the average
            let average: Double = sum/count
            averageArray.append(average)
        }
        return averageArray
    }
    
}
