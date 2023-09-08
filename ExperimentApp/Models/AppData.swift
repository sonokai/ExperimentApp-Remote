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
    var moodExperiments: [MoodExperiment]
     
    init(sleepExperiments: [SleepExperiment], dayExperiments: [DayExperiment], moodExperiments: [MoodExperiment]) {
        self.sleepExperiments = sleepExperiments
        self.dayExperiments = dayExperiments
        self.moodExperiments = moodExperiments
    }
    
    static var emptyData: AppData = AppData(sleepExperiments: [], dayExperiments: [], moodExperiments: [])
    static var sampleData: AppData = AppData(sleepExperiments: [SleepExperiment.sampleExperiment1], dayExperiments: [DayExperiment.sampleExperiment], moodExperiments: MoodExperiment.sampleExperiments)
}
