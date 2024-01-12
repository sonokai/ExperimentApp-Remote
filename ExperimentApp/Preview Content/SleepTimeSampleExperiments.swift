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
    
}
