//
//  SleepExperiment.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/3/23.
//

import Foundation

struct SleepExperiment: Identifiable{
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
enum DependentVariable: String{
    case productivity = "productivity"
    case quality = "quality"
    case both = "both"
}
enum IndependentVariable: String{
    case hoursSlept = "hours slept"
    case both = "both"
    case bedtime = "bedtime"
    case waketime = "waketime"
}

extension SleepExperiment{
    static let emptyExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime)
    
    static let sampleExperiment1: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime, entries: SleepEntry.sampleData, name: "Customized Sleep Experiment", notes: "I took notes")
    
    
    
}
//eventually make these enums private
// eventually add functions here to calculate results
