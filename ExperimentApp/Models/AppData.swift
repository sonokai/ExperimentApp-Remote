//
//  AppData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/27/23.
//

import Foundation

struct AppData: Codable{
    var sleepExperiments: [SleepExperiment]
    var dayExperiments: [DayExperiment]
     
    init(sleepExperiments: [SleepExperiment], dayExperiments: [DayExperiment]) {
        self.sleepExperiments = sleepExperiments
        self.dayExperiments = dayExperiments
    }
    
    static var emptyData: AppData = AppData(sleepExperiments: [], dayExperiments: [])
}
