//
//  WaketimeBarChartEntry.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import Foundation
struct WaketimeBarChartEntry: Identifiable{
    let id: UUID
    let time: String
    let value: Double
    let isOptimal: Bool
    //initializes using a time
    //dependent vairable should only either be quality or productivity
    init(id: UUID = UUID(),experiment: SleepExperiment, dependentVariable: SleepExperiment.DependentVariable, time: Int, isOptimal: Bool = false) {
        self.id = id
        
        let date = WaketimeBarChartEntry.dateFromMinutes(time)
        self.time = "\(date.simplifyDateToTimeString()) - \(date.addMinutesToDate(minutesToAdd: 30).simplifyDateToTimeString())"
        if(dependentVariable == .quality || experiment.dependentVariable == .quality){
            self.value = experiment.averageOfWaketimeInterval(at: time, for: 30, dependentVariable: .quality)
        } else if (dependentVariable == .productivity || experiment.dependentVariable == .productivity){
            self.value = experiment.averageOfWaketimeInterval(at: time, for: 30, dependentVariable: .productivity)
        } else {
            //default condition: should never be called
            
            self.value = experiment.averageOfWaketimeInterval(at: time, for: 30, dependentVariable: dependentVariable)
        }
        
        self.isOptimal = isOptimal
    }
    
    static func dateFromMinutes(_ minutes: Int) -> Date {
        return BedtimeBarChartEntry.dateFromMinutes(minutes)
    }
}
