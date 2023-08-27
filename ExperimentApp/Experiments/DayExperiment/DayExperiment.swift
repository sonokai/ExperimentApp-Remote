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
   // let time: Time //will be the independent variable
    let independentVariable: IndependentVariable
    var entries: [DayEntry] = []
    var notes: String = "Take notes here"
    var name: String = "Time of day Experiment"
  
    
    
    
    init(id: UUID = UUID(), goalEntries: Int, independentVariable: IndependentVariable) {
        self.id = id
        self.goalEntries = goalEntries
        self.independentVariable = independentVariable
    }
    //for testing
    init(id: UUID = UUID(), goalEntries: Int, independentVariable: IndependentVariable, entries: [DayEntry], name: String, notes: String) {
        self.id = id
        self.goalEntries = goalEntries
        self.independentVariable = independentVariable
        self.entries = entries
        self.name = name
        self.notes = notes
    }
    
}

extension DayExperiment{
    
    enum VariableType: String, Codable{
        case twoTimesOfDay = "twoTimesOfDay"
        case threeTimesOfDay = "threeTimesOfDay"
        case fourTimesOfDay = "fourTimesOfDay"
    }  //might be totally unnecessary
    
    struct IndependentVariable: Identifiable, Codable{
        let id: UUID
        let variableType: VariableType
        let hasMorning: Bool
        let hasAfternoon: Bool
        let hasEvening: Bool
        
        init(id: UUID = UUID(), variableType: VariableType, hasMorning: Bool, hasAfternoon: Bool, hasEvening: Bool){
            self.id = id
            self.hasMorning = hasMorning
            self.hasAfternoon = hasAfternoon
            self.hasEvening = hasEvening
            self.variableType = variableType
        }
        
    }
    
    static let sampleIndependentVariable = IndependentVariable(variableType : .twoTimesOfDay, hasMorning :  true, hasAfternoon : true, hasEvening : false)
    
    static let sampleExperiment: DayExperiment = DayExperiment(goalEntries: 50, independentVariable: sampleIndependentVariable, entries: DayEntry.sampleData, name: "Sample Day Experiment", notes: "yay")
    
}

