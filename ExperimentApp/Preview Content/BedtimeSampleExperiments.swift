//
//  BedtimeSampleExperiments.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation
extension SleepExperiment{
    static let highXRangeBedtimeExperiment = SleepExperiment(dependentVariable: .quality, independentVariable: .bedtime, entries: SleepExperiment.data)
    //duplicate times crash bedtime but not waketime???
    static let data : [SleepEntry] = [
        

        SleepEntry(date: createDate(month: 12, day: 1, year: 2023)!, bedtime: createTime(hour: 11, minute: 13), quality: 8),
        SleepEntry(date: createDate(month: 12, day: 2, year: 2023)!, bedtime: createTime(hour: 11, minute: 12), quality: 8),
        SleepEntry(date: createDate(month: 12, day: 3, year: 2023)!, bedtime: createTime(hour: 11, minute: 30), quality: 5),
        SleepEntry(date: createDate(month: 12, day: 4, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 9),
        SleepEntry(date: createDate(month: 12, day: 5, year: 2023)!, bedtime: createTime(hour: 11, minute: 20), quality: 7),
        SleepEntry(date: createDate(month: 12, day: 6, year: 2023)!, bedtime: createTime(hour: 11, minute: 10), quality: 7),
         
    ]
    
    /* this exists
    static func createDate(month: Int, day: Int, year: Int) -> Date? {
    }
     */
    static func createTime(hour: Int, minute: Int) -> Date{
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
    }
}
