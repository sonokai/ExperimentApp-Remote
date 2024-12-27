//
//  BedtimeSampleExperiments.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation
extension SleepExperiment{
    static let highXRangeBedtimeExperiment = SleepExperiment(dependentVariable: .quality, independentVariable: .bedtime, entries: SleepExperiment.data)
    
    static let data : [SleepEntry] = [
        

        SleepEntry(date: createDate(month: 12, day: 1, year: 2023)!, bedtime: createTime(hour: 11, minute: 30), quality: 8),
        SleepEntry(date: createDate(month: 12, day: 2, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 8),
        SleepEntry(date: createDate(month: 12, day: 3, year: 2023)!, bedtime: createTime(hour: 11, minute: 45), quality: 5),
        SleepEntry(date: createDate(month: 12, day: 4, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 9),
        SleepEntry(date: createDate(month: 12, day: 5, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 7),
        SleepEntry(date: createDate(month: 12, day: 6, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 7),
         
    ]
    
    /* this exists
    static func createDate(month: Int, day: Int, year: Int) -> Date? {
    }
     */
    static func createTime(hour: Int, minute: Int) -> Date{
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
    }
    
    
    static let highDateRangeBedtimeExperiment = SleepExperiment(dependentVariable: .quality, independentVariable: .bedtime, entries: SleepExperiment.data2)
    static let data2 : [SleepEntry] = [
        

        SleepEntry(date: createDate(month: 12, day: 20, year: 2023)!, bedtime: createTime(hour: 1, minute: 30), quality: 8),
        SleepEntry(date: createDate(month: 1, day: 5, year: 2024)!, bedtime: createTime(hour: 11, minute: 20), quality: 8),
        SleepEntry(date: createDate(month: 12, day: 23, year: 2023)!, bedtime: createTime(hour: 11, minute: 45), quality: 5),
        SleepEntry(date: createDate(month: 12, day: 24, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 9),
        SleepEntry(date: createDate(month: 12, day: 25, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 7),
        SleepEntry(date: createDate(month: 12, day: 26, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 7),
        SleepEntry(date: createDate(month: 12, day: 27, year: 2023)!, bedtime: createTime(hour: 12, minute: 20), quality: 7),
        SleepEntry(date: createDate(month: 12, day: 28, year: 2023)!, bedtime: createTime(hour: 12, minute: 20), quality: 7),
         
    ]
}
