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
       
        var times: [String]
        var customtimes: [customTime] = []
        
        func hasEmptyCustomTimes() -> Bool{
            return customtimes.count == 0
        }
        init(id: UUID = UUID(), times: [String]){
            self.id = id
            self.times = times
            
        }
        
        init(id: UUID = UUID(), times: [String], customtimes: [customTime]){
            self.id = id
            self.times = times
            self.customtimes = customtimes
        }
        
        struct customTime: Identifiable, Codable{
            
            
            let id: UUID
            let name: String
            init(id: UUID = UUID(), name: String) {
                self.id = id
                self.name = name
            }
        }
        
    }
    
    
    
    static let sampleCustomTime1 = IndependentVariable.customTime(name: "Before dinner")
    static let sampleCustomTime2 = IndependentVariable.customTime(name: "After school")
    static let sampleCustomTimes = [
    sampleCustomTime1, sampleCustomTime2
    ]
    static let sampleIndependentVariable = IndependentVariable(times: [], customtimes: sampleCustomTimes)
    
    static let sampleExperiment: DayExperiment = DayExperiment(goalEntries: 50, independentVariable: sampleIndependentVariable,dependentVariable: .focus, entries:  DayEntry.sampleData, name: "Sample Day Experiment", notes: "yay")
    
    
    static let sampleExperimentArray: [DayExperiment] = [
    sampleExperiment, sampleExperiment
    ]
    
}

