//
//  SleepExperimentSamples.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/14/23.
//

import Foundation

extension SleepExperiment{
    
    static let emptyExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime)
    
    static let bedtimeSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime, entries: SleepEntry.sampleData, name: "Sleep Experiment 1", notes: "notes")
    static let bedtimeSampleExperiment2: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .productivity, independentVariable: .bedtime, entries: sampleDataForBedtime2, name: "Sleep Experiment 2", notes: "notes")
    //bedtime experiment for testing cross day plotting
    static let midnightSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .bedtime, entries: sampleDataForCrossMidnight, name: "Sleep Experiment 12", notes: "notes")
    static let experimentArray: [SleepExperiment] = [
    bedtimeSampleExperiment, bothTimesSampleExperiment, hoursSleptSampleExperiment
    ]
    static let bedtimeSampleExperiment3: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .bedtime, entries: sampleDataForBedtime2, name: "Sleep Experiment 3", notes: "notes")
    static let bothTimesSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .both, entries: sampleDataForExperiment2, name: "Sleep Experiment 2", notes: "notes")
    static let waketimeSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .productivity, independentVariable: .waketime, entries: sampleDataForExperiment2, name: "Waketime experiment 1", notes: "notes?")
    static let waketimeSampleExperiment2: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .waketime, entries: sampleDataForExperiment2, name: "Waketime experiment 2", notes: "notes?")
    static let waketimeSampleExperiment3: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .waketime, entries: sampleDataForExperiment2, name: "Waketime experiment 3", notes: "notes?")
    static let bedtimebothExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .bedtime, entries:sampleData12, name: "", notes: "")
    static let hoursSleptSampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .both, independentVariable: .hoursSlept, entries: sampleDataForExperiment3, name: "Sleep Experiment 3", notes: "notes")
    
    
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
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!,
                   quality: 5,
                   productivity: 5),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date())!,
                   quality: 6,
                   productivity: 7),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 10, minute: 48, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 9, minute: 40, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 8),
        SleepEntry(date: Date(),
                   bedtime: Calendar.current.date(bySettingHour: 11, minute: 21, second: 0, of: Date())!,
                   waketime: Calendar.current.date(bySettingHour: 10, minute: 10, second: 0, of: Date())!,
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
        
        SleepEntry(date: Date(),
                   quality: 5,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 30),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 7,
                   hoursSlept: 11, minutesSlept: 30),
        SleepEntry(date: Date(),
                   quality: 7,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 40),
        SleepEntry(date: Date(),
                   quality: 3,
                   productivity: 8,
                   hoursSlept: 10, minutesSlept: 20),
        SleepEntry(date: Date(),
                   quality: 4,
                   productivity: 8,
                   hoursSlept: 11, minutesSlept: 15),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 9,
                   hoursSlept: 10, minutesSlept: 55),
        SleepEntry(date: Date(),
                   quality: 3,
                   productivity: 10,
                   hoursSlept: 10, minutesSlept: 45),
        SleepEntry(date: Date(),
                   quality: 5,
                   productivity: 8,
                   hoursSlept: 11, minutesSlept: 20),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 7,
                   hoursSlept: 10, minutesSlept: 40),
        SleepEntry(date: Date(),
                   quality: 5,
                   productivity: 7,
                   hoursSlept: 10, minutesSlept: 0),
        SleepEntry(date: Date(),
                   quality: 6,
                   productivity: 10,
                   hoursSlept: 11, minutesSlept: 30),
        SleepEntry(date: Date(),
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
                   productivity: 10),
        SleepEntry(date: createDate(month: 10, day: 5, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 23, minute: 45, second: 0, of: Date())!,
                   quality: 7,
                   productivity: 10),
        SleepEntry(date: createDate(month: 10, day: 6, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 23, minute: 58, second: 0, of: Date())!,
                   quality: 10,
                   productivity: 10),
        SleepEntry(date: createDate(month: 10, day: 7, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!,
                   quality: 10,
                   productivity: 10),
        SleepEntry(date: createDate(month: 10, day: 8, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 0, minute: 30, second: 0, of: Date())!,
                   quality: 8,
                   productivity: 10),
        SleepEntry(date: createDate(month: 10, day: 9, year: 2023)!,
                   bedtime: Calendar.current.date(bySettingHour: 1, minute: 0, second: 0, of: Date())!,
                   quality: 9,
                   productivity: 10),
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
