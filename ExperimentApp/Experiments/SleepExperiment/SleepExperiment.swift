//
//  SleepExperiment.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/3/23.
//

import Foundation

struct SleepExperiment: Identifiable, Codable{
    let id: UUID
    let startDate: Date
    let goalEntries: Int //ask user how many entries they want to have
    let dependentVariable: DependentVariable //ask user if they want to track how sleep affects their productivity or quality of day
    let independentVariable: IndependentVariable //ask user if they want to guess how much hours they slept on their own or only track bedtime, waketime, or both bedtime and waketime for the maximum data
    var entries: [SleepEntry] = []
    var insights: [Insight] = []
    var name: String = "Sleep Experiment"
    var newSleepEntry = NewSleepEntry(date: Date())
    var isEditing: Bool = false
    var endDate: Date?
    
    var isFinished: Bool = false
    var medal: Medal = .none
    
    //normal initializer
    init(id: UUID = UUID(), goalEntries: Int, dependentVariable: DependentVariable, independentVariable: IndependentVariable) {
        self.id = id
        self.startDate = Date()
        self.goalEntries = goalEntries
        self.dependentVariable = dependentVariable
        self.independentVariable = independentVariable
    }
    
    //for testing
    init(id: UUID = UUID(), goalEntries: Int, startDate: Date = Date(), dependentVariable: DependentVariable, independentVariable: IndependentVariable, entries: [SleepEntry], name: String, insights: [Insight] = []) {
        self.id = id
        self.startDate = startDate
        self.goalEntries = goalEntries
        self.dependentVariable = dependentVariable
        self.independentVariable = independentVariable
        self.entries = entries
        self.name = name
        self.insights = insights
    }
    //another one for teting
    init(id: UUID = UUID(), dependentVariable: DependentVariable, independentVariable: IndependentVariable, entries: [SleepEntry]) {
        self.id = id
        self.startDate = Date()
        self.goalEntries = 0
        self.dependentVariable = dependentVariable
        self.independentVariable = independentVariable
        self.entries = entries
    }
}
struct Insight: Codable, Hashable, Identifiable{
    let id: UUID
    var text: String
    var date: Date
    
    init(id: UUID = UUID(), text: String, date: Date){
        self.id = id
        self.text = text
        self.date = date
    }
}

extension SleepExperiment{
    
    enum DependentVariable: String, Codable, CaseIterable, Identifiable{
        var id: Self{
            return self
        }
        case productivity = "Productivity"
        case quality = "Quality"
        case both = "both"
        
        var name: String {
            rawValue.capitalized
        }
        var nameInSentence: String{
            switch self{
            case .productivity: return "productivity"
            case .quality: return "quality of day"
            case .both: return "shouldn't be using this"
            }
        }
    }
    enum IndependentVariable: String, Codable, CaseIterable, Identifiable{
        var id: Self {
            return self
        }
        case bedtime = "Bedtime"
        case waketime = "Wake time"
        case both = "Both bedtime and wake time"
        case hoursSlept = "Sleep time"
        
        var name: String {
            rawValue
        }
    }
}

