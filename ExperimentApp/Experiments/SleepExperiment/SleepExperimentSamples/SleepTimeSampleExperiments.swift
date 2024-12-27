//
//  SleepTimeSampleExperiments.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation

extension SleepExperiment{
    static let sleepTimeLargeRange = SleepExperiment(dependentVariable: .productivity, independentVariable: .hoursSlept, entries: data3)
    static let data3: [SleepEntry] = [
        SleepEntry(date: createDate(month: 12, day: 1, year: 2023)!, productivity: 8, hoursSlept: 0, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 2, year: 2023)!, productivity: 8, hoursSlept: 2, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 3, year: 2023)!, productivity: 8, hoursSlept: 3, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 4, year: 2023)!, productivity: 8, hoursSlept: 5, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 5, year: 2023)!, productivity: 8, hoursSlept: 7, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 6, year: 2023)!, productivity: 8, hoursSlept: 8, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 7, year: 2023)!, productivity: 8, hoursSlept: 11, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 8, year: 2023)!, productivity: 8, hoursSlept: 15, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 9, year: 2023)!, productivity: 8, hoursSlept: 22, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 10, year: 2024)!, productivity: 8, hoursSlept: 23, minutesSlept: 0),
    ]
    

    static let testing = SleepExperiment(dependentVariable: .productivity, independentVariable: .hoursSlept, entries: data3)
    
    static let sampledata4: [SleepEntry] = [
        //SleepEntry(date: createDate(month: 12, day: 1, year: 2023)!, bedtime: createTime(hour: 20, minute: 30), waketime: createTime(hour: 8, minute: 30), quality: 8, productivity: 8, hoursSlept: 12, minutesSlept: 0),
        /*
        SleepEntry(date: createDate(month: 12, day: 2, year: 2023)!, bedtime: createTime(hour: 21, minute: 0), waketime: createTime(hour: 8, minute: 45), quality: 7, productivity: 9, hoursSlept: 11, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 3, year: 2023)!, bedtime: createTime(hour: 22, minute: 15), waketime: createTime(hour: 9, minute: 0), quality: 6, productivity: 7, hoursSlept: 10, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 4, year: 2023)!, bedtime: createTime(hour: 23, minute: 0), waketime: createTime(hour: 9, minute: 15), quality: 9, productivity: 8, hoursSlept: 10, minutesSlept: 15),
        SleepEntry(date: createDate(month: 12, day: 5, year: 2023)!, bedtime: createTime(hour: 20, minute: 45), waketime: createTime(hour: 8, minute: 30), quality: 8, productivity: 8, hoursSlept: 11, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 6, year: 2023)!, bedtime: createTime(hour: 21, minute: 30), waketime: createTime(hour: 9, minute: 0), quality: 7, productivity: 9, hoursSlept: 10, minutesSlept: 30),
        SleepEntry(date: createDate(month: 12, day: 7, year: 2023)!, bedtime: createTime(hour: 22, minute: 0), waketime: createTime(hour: 8, minute: 45), quality: 6, productivity: 7, hoursSlept: 10, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 8, year: 2023)!, bedtime: createTime(hour: 23, minute: 15), waketime: createTime(hour: 9, minute: 0), quality: 9, productivity: 8, hoursSlept: 9, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 9, year: 2023)!, bedtime: createTime(hour: 20, minute: 30), waketime: createTime(hour: 8, minute: 30), quality: 8, productivity: 8, hoursSlept: 12, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 10, year: 2023)!, bedtime: createTime(hour: 21, minute: 0), waketime: createTime(hour: 8, minute: 45), quality: 7, productivity: 9, hoursSlept: 11, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 11, year: 2023)!, bedtime: createTime(hour: 22, minute: 15), waketime: createTime(hour: 9, minute: 0), quality: 6, productivity: 7, hoursSlept: 10, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 12, year: 2023)!, bedtime: createTime(hour: 23, minute: 0), waketime: createTime(hour: 9, minute: 15), quality: 9, productivity: 8, hoursSlept: 10, minutesSlept: 15),
        SleepEntry(date: createDate(month: 12, day: 13, year: 2023)!, bedtime: createTime(hour: 20, minute: 45), waketime: createTime(hour: 8, minute: 30), quality: 8, productivity: 8, hoursSlept: 11, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 14, year: 2023)!, bedtime: createTime(hour: 21, minute: 30), waketime: createTime(hour: 9, minute: 0), quality: 7, productivity: 9, hoursSlept: 10, minutesSlept: 30),
        SleepEntry(date: createDate(month: 12, day: 15, year: 2023)!, bedtime: createTime(hour: 22, minute: 0), waketime: createTime(hour: 8, minute: 45), quality: 6, productivity: 7, hoursSlept: 10, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 16, year: 2023)!, bedtime: createTime(hour: 23, minute: 15), waketime: createTime(hour: 9, minute: 0), quality: 9, productivity: 8, hoursSlept: 9, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 17, year: 2023)!, bedtime: createTime(hour: 20, minute: 30), waketime: createTime(hour: 8, minute: 30), quality: 8, productivity: 8, hoursSlept: 12, minutesSlept: 0),
        SleepEntry(date: createDate(month: 12, day: 18, year: 2023)!, bedtime: createTime(hour: 21, minute: 0), waketime: createTime(hour: 8, minute: 45), quality: 7, productivity: 9, hoursSlept: 11, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 19, year: 2023)!, bedtime: createTime(hour: 22, minute: 15), waketime: createTime(hour: 9, minute: 0), quality: 6, productivity: 7, hoursSlept: 10, minutesSlept: 45),
        SleepEntry(date: createDate(month: 12, day: 20, year: 2023)!, bedtime: createTime(hour: 23, minute: 0), waketime: createTime(hour: 9, minute: 15), quality: 9, productivity: 8, hoursSlept: 10, minutesSlept: 15),*/
    ]
}
