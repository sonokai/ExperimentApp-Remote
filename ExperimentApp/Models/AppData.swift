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
    
    
    var finishedExperiments: [FinishedExperiment]
    
    init(sleepExperiments: [SleepExperiment], dayExperiments: [DayExperiment], moodExperiments: [MoodExperiment], finishedExperiments: [FinishedExperiment]) {
        self.sleepExperiments = sleepExperiments
        self.dayExperiments = dayExperiments
        self.moodExperiments = moodExperiments
        self.finishedExperiments = finishedExperiments
    }
    
    static var emptyData: AppData = AppData(sleepExperiments: [], dayExperiments: [], moodExperiments: [], finishedExperiments: [])
    static var sampleData: AppData = AppData(sleepExperiments: [SleepExperiment.bedtimeSampleExperiment], dayExperiments: [DayExperiment.sampleExperiment], moodExperiments: MoodExperiment.sampleExperiments, finishedExperiments: FinishedExperiment.sampleArray)
}
