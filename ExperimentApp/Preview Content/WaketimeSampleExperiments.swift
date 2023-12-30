//
//  WaketimeSampleExperiments.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation
extension SleepExperiment{
    static let testCrash = SleepExperiment(dependentVariable: .productivity, independentVariable: .waketime, entries: data1)
    
    static let data1: [SleepEntry] = [
        SleepEntry(date: createDate(month: 12, day: 1, year: 2023)!, waketime: createTime(hour: 11, minute: 13), productivity: 8),
        SleepEntry(date: createDate(month: 12, day: 2, year: 2023)!, waketime: createTime(hour: 11, minute: 12), productivity: 8),
        SleepEntry(date: createDate(month: 12, day: 3, year: 2023)!, waketime: createTime(hour: 11, minute: 10), productivity: 5),
        SleepEntry(date: createDate(month: 12, day: 4, year: 2023)!, waketime : createTime(hour: 11, minute: 10), productivity: 9),
        SleepEntry(date: createDate(month: 12, day: 5, year: 2023)!, waketime: createTime(hour: 11, minute: 10), productivity: 7),
    ]
}
