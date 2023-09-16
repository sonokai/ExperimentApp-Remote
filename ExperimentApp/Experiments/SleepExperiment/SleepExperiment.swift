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
    
    static let sampleExperiment1: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime, entries: SleepEntry.sampleData, name: "Sleep Experiment 1", notes: "notes")
    
    static let sampleExperiment2: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .both, entries: sampleDataForExperiment2, name: "Sleep Experiment 2", notes: "notes")
    
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
                   productivity: 8)
        
    ]
    
    
    static let sampleExperiment3: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .hoursSlept, entries: sampleDataForExperiment3, name: "Sleep Experiment 3", notes: "notes")
    
    static let sampleDataForExperiment3: [SleepEntry] =
    [
        
        SleepEntry(date: Date(),
                   quality: 5,
                   productivity: 5,
                   hoursSlept: 10),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 7,
                   hoursSlept: 11),
        SleepEntry(date: Date(),
                   quality: 7,
                   productivity: 8,
                   hoursSlept: 10)
        
    ]
    
    static let experimentArray: [SleepExperiment] = [
    sampleExperiment1, sampleExperiment2, sampleExperiment3
    ]
    
}

// eventually add functions here to calculate results
