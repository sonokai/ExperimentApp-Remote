//
//  AppData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/27/23.
//

import Foundation
// add any settings, experiments, and things the app needs to load and save here
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
    static var sampleData: AppData = AppData(sleepExperiments: [SleepExperiment.bedtimeSampleExperiment], dayExperiments: [DayExperiment.sampleExperiment], moodExperiments: MoodExperiment.sampleExperiments)
}
