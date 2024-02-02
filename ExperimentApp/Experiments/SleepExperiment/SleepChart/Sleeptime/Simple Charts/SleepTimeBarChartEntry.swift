//
//  SleepTimeBarChartEntry.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI

struct SleepTimeBarChartEntry: Identifiable{
    let id: UUID
    let time: String
    let value: Double
    let isOptimal: Bool
    let hasNoData: Bool
    //initializes using a time
    //dependent vairable should only either be quality or productivity
    init(id: UUID = UUID(), experiment: SleepExperiment, dependentVariable: SleepExperiment.DependentVariable, time: Int, isOptimal: Bool = false) {
        self.id = id
        
        let date = SleepTimeBarChartEntry.dateFromMinutes(time)
        self.time = "\(date.simplifyDateToHMM()) - \(date.addMinutesToDate(minutesToAdd: 30).simplifyDateToHMM())"
        if(dependentVariable == .quality || experiment.dependentVariable == .quality){
            let value = experiment.averageOfSleepTimeInterval(at: time, for: 30, dependentVariable: .quality)
            if(value == 0){
                self.value = 5
                self.hasNoData = true
            } else {
                self.value = value
                self.hasNoData = false
            }
        } else if (dependentVariable == .productivity || experiment.dependentVariable == .productivity){
            let value = experiment.averageOfSleepTimeInterval(at: time, for: 30, dependentVariable: .productivity)
            if(value == 0){
                self.value = 5
                self.hasNoData = true
            } else {
                self.value = value
                self.hasNoData = false
            }
        } else {
            //default condition: should never be called
            self.hasNoData = false
            self.value = experiment.averageOfSleepTimeInterval(at: time, for: 30, dependentVariable: dependentVariable)
        }
        
        self.isOptimal = isOptimal
    }
    
    static func dateFromMinutes(_ minutes: Int) -> Date {
        return BedtimeBarChartEntry.dateFromMinutes(minutes)
    }
}
