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
    
    init(sleepExperiments: [SleepExperiment], dayExperiments: [DayExperiment]) {
        self.sleepExperiments = sleepExperiments
        self.dayExperiments = dayExperiments
    }
    

    static var emptyData: AppData = AppData(sleepExperiments: [], dayExperiments: [])
    
    static var sampleData: AppData = AppData(sleepExperiments: [SleepExperiment.bothTimesSampleExperiment, SleepExperiment.bedtimebothExperiment, SleepExperiment.waketimeSampleExperiment], dayExperiments: [DayExperiment.sampleExperiment])
    
    static var sampleData2: AppData = AppData(sleepExperiments: [SleepExperiment.bedtimeShortExperiment], dayExperiments: [DayExperiment.sampleExperiment])

}
