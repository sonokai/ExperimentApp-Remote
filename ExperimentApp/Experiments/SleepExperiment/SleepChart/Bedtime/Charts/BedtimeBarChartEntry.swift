//
//  BedtimeBarChartEntry.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import Foundation
struct BedtimeBarChartEntry: Identifiable{
    let id: UUID
    let time: String
    let value: Double
    let isOptimal: Bool
    let hasNoData: Bool
    //initializes using a time
    //dependent variable should only either be quality or producitvity
    init(id: UUID = UUID(),experiment: SleepExperiment, dependentVariable: SleepExperiment.DependentVariable, time: Int, isOptimal: Bool = false) {
        self.id = id
        
        let date = BedtimeBarChartEntry.dateFromMinutes(time)
        self.time = "\(date.simplifyDateToTimeString()) - \(date.addMinutesToDate(minutesToAdd: 30).simplifyDateToTimeString())"
        if(dependentVariable == .quality || experiment.dependentVariable == .quality){
            let value = experiment.averageOfBedtimeInterval(at: time, for: 30, dependentVariable: .quality)
            if(value == 0){
                self.value = 5
                self.hasNoData = true
            } else {
                self.value = value
                self.hasNoData = false
            }
        } else if (dependentVariable == .productivity || experiment.dependentVariable == .productivity){
            let value = experiment.averageOfBedtimeInterval(at: time, for: 30, dependentVariable: .productivity)
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
            self.value = experiment.averageOfBedtimeInterval(at: time, for: 30, dependentVariable: dependentVariable)
        }
        
        self.isOptimal = isOptimal
    }
    
    static func dateFromMinutes(_ minutes: Int) -> Date {
        // Adjust minutes if greater than 1440
        let adjustedMinutes = minutes % 1440
        
        // Get the current calendar
        let calendar = Calendar.current
        
        // Get the current date
        let currentDate = Date()
        
        // Get the start of the current day (midnight)
        let midnightDate = calendar.startOfDay(for: currentDate)
        
        // Calculate the time interval from midnight
        let timeInterval = TimeInterval(adjustedMinutes * 60)
        
        // Create a new date by adding the time interval to midnight
        let resultDate = midnightDate.addingTimeInterval(timeInterval)
        
        return resultDate
    }
}
