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

    var moodExperiments: [MoodTracker]
    
    
    var finishedExperiments: [FinishedExperiment]
    
    init(sleepExperiments: [SleepExperiment], dayExperiments: [DayExperiment], moodExperiments: [MoodTracker], finishedExperiments: [FinishedExperiment]) {

        self.sleepExperiments = sleepExperiments
        self.dayExperiments = dayExperiments
        self.moodExperiments = moodExperiments
        self.finishedExperiments = finishedExperiments
    }
    

    static var emptyData: AppData = AppData(sleepExperiments: [], dayExperiments: [], moodExperiments: [], finishedExperiments: [])
    static var sampleData: AppData = AppData(sleepExperiments: [SleepExperiment.bothTimesSampleExperiment], dayExperiments: [DayExperiment.sampleExperiment], moodExperiments: MoodTracker.sampleExperiments, finishedExperiments: FinishedExperiment.sampleArray)
    static var sampleData2: AppData = AppData(sleepExperiments: [SleepExperiment.bedtimeShortExperiment], dayExperiments: [DayExperiment.sampleExperiment], moodExperiments: MoodTracker.sampleExperiments, finishedExperiments: FinishedExperiment.sampleArray)

}
