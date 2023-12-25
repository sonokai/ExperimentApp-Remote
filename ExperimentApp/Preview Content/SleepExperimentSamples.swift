//
//  SleepExperimentSamples.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/14/23.
//

import Foundation

extension SleepExperiment{
    
    static let emptyExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime)
    
    static let bedtimeSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime, entries: SleepEntry.sampleData, name: "Sleep Experiment 1")
    static let bedtimeSampleExperiment2: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .productivity, independentVariable: .bedtime, entries: sampleDataForBedtime2, name: "Sleep Experiment 2")
    //bedtime experiment for testing cross day plotting
    static let midnightSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .bedtime, entries: sampleDataForCrossMidnight, name: "Sleep Experiment 12")
    static let experimentArray: [SleepExperiment] = [
    bedtimeSampleExperiment, bothTimesSampleExperiment, hoursSleptSampleExperiment
    ]
    static let bedtimeSampleExperiment3: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .bedtime, entries: sampleDataForBedtime2, name: "Sleep Experiment 3")
    static let bothTimesSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .both, entries: sampleDataForExperiment2, name: "Sleep Experiment 2")
    static let waketimeSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .productivity, independentVariable: .waketime, entries: sampleDataForExperiment2, name: "Waketime experiment 1")
    static let waketimeSampleExperiment2: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .waketime, entries: sampleDataForExperiment2, name: "Waketime experiment 2")
    static let waketimeSampleExperiment3: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .waketime, entries: sampleDataForExperiment2, name: "Waketime experiment 3")
    static let bedtimebothExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .bedtime, entries:sampleData12, name: "")
    static let hoursSleptSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .hoursSlept, entries: sampleDataForExperiment3, name: "Sleep Experiment 3")
    
    
    static let sampleDataForBedtime2: [SleepEntry] = [
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!,
                   productivity: 5),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 35, second: 0, of: Date())!,
                   productivity: 5),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 40, second: 0, of: Date())!,
                   productivity: 5),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 45, second: 0, of: Date())!,
                   productivity: 5),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 50, second: 0, of: Date())!,
                   productivity: 5),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 55, second: 0, of: Date())!,
                   productivity: 5),
    ]
    
    static let sampleDataForExperiment2: [SleepEntry] =
    [
        SleepEntry(date: createDate(month: 10, day: 8, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!,
                   quality: 5,
                   productivity: 5),
        SleepEntry(date: createDate(month: 10, day: 9, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date())!,
                   quality: 6,
                   productivity: 7),
        SleepEntry(date: createDate(month: 10, day: 10, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: createDate(month: 10, day: 11, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 10, minute: 38, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 10, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: createDate(month: 10, day: 12, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 11, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 00, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: createDate(month: 10, day: 13, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 21, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: createDate(month: 10, day: 14, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 12, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 39, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: createDate(month: 10, day: 15, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 21, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 20, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
    ]
    
    
    static let sampleData12: [SleepEntry] = [
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 10, minute: 48, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!,
                   quality: 8,
                   productivity: 9),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 20, second: 0, of: Date())!,
                   quality: 9,
                   productivity: 10)
    ]
    
    
    static let sampleDataForExperiment3: [SleepEntry] =
    [
        
        SleepEntry(date: createDate(month: 10, day: 14, year: 2023)!,
                   quality: 5,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 30),
        SleepEntry(date: createDate(month: 10, day: 15, year: 2023)!,
                   quality: 6,
                   productivity: 7,
                   hoursSlept: 11, minutesSlept: 30),
        SleepEntry(date: createDate(month: 10, day: 16, year: 2023)!,
                   quality: 7,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 40),
        SleepEntry(date: createDate(month: 10, day: 17, year: 2023)!,
                   quality: 3,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 20),
        SleepEntry(date: createDate(month: 10, day: 18, year: 2023)!,
                   quality: 4,
                   productivity: 8,
                   hoursSlept: 11, minutesSlept: 15),
        SleepEntry(date: createDate(month: 10, day: 19, year: 2023)!,
                   quality: 6,
                   productivity: 9,
                   hoursSlept: 10, minutesSlept: 55),
        SleepEntry(date: createDate(month: 10, day: 20, year: 2023)!,
                   quality: 3,
                   productivity: 10,
                   hoursSlept: 10, minutesSlept: 45),
        SleepEntry(date: createDate(month: 10, day: 21, year: 2023)!,
                   quality: 5,
                   productivity: 8,
                   hoursSlept: 11, minutesSlept: 20),
        SleepEntry(date: createDate(month: 10, day: 22, year: 2023)!,
                   quality: 6,
                   productivity: 7,
                   hoursSlept: 10, minutesSlept: 40),
        SleepEntry(date: createDate(month: 10, day: 23, year: 2023)!,
                   quality: 5,
                   productivity: 7,
                   hoursSlept: 10, minutesSlept: 0),
        SleepEntry(date: createDate(month: 10, day: 24, year: 2023)!,
                   quality: 6,
                   productivity: 10,
                   hoursSlept: 11, minutesSlept: 30),
        SleepEntry(date: createDate(month: 10, day: 25, year: 2023)!,
                   quality: 7,
                   productivity: 9,
                   hoursSlept: 12, minutesSlept: 40)
        
    ]
    static let sampleDataForCrossMidnight: [SleepEntry] = [
        
        SleepEntry(date: createDate(month: 10, day: 3, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 23, minute: 0, second: 0, of: Date())!,
                   quality: 6,
                   productivity: 10),
        SleepEntry(date: createDate(month: 10, day: 4, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 23, minute: 30, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 9),
        SleepEntry(date: createDate(month: 10, day: 5, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 23, minute: 45, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 9),
        SleepEntry(date: createDate(month: 10, day: 6, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 23, minute: 58, second: 0, of: Date())!,
                   quality: 10,
                   productivity: 10),
        SleepEntry(date: createDate(month: 10, day: 7, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!,
                   quality: 10,
                   productivity: 9),
        SleepEntry(date: createDate(month: 10, day: 8, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 0, minute: 30, second: 0, of: Date())!,
                   quality: 8,
                   productivity: 7),
        SleepEntry(date: createDate(month: 10, day: 9, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 1, minute: 0, second: 0, of: Date())!,
                   quality: 9,
                   productivity: 7),
    ]
    
    static func createDate(month: Int, day: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
    
}
