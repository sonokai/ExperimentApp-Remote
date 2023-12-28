//
//  SleepExperimentErrors.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/27/23.
//

import Foundation

enum SleepExperimentError: Error{
    case noEntries
    case insufficientEntriesInInterval
    case dateConversionError
    case wrongIndependentVariable
    case intervalExceedsRange
    var description: String {
        switch self{
        case .noEntries: return "You need at least one entry to calculate an optimal interval!"
        case .insufficientEntriesInInterval: return "There aren't any intervals with the required entry count. Either add more entries or reduce the required entry count."
        case .dateConversionError: return "Something went wrong with the date converting."
        case .wrongIndependentVariable: return "Used a bedtime function when the experiment's dependent variable does not include bedtime"
        case .intervalExceedsRange: return "The interval is bigger than your range! Try increasing your chart range or reducing your interval size."
        }
    }
}
