//
//  IndependentVariableFunctions.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation
//independent variable stats
extension SleepExperiment{
    func getAverageQuality() -> String{
        if(entries.count == 0){
            return "Needs more data"
        }
        var quality = 0
        for entry in entries{
            quality += entry.quality
        }
        return roundTwoDigits(from: (Double)(quality)/(Double)(entries.count))
    }
    func getAverageProductivity() -> String{
        if(entries.count == 0){
            return "Needs more data"
        }
        var productivity = 0
        for entry in entries{
            productivity += entry.productivity
        }
        return roundTwoDigits(from: (Double)(productivity)/(Double)(entries.count))
    }
    func roundTwoDigits(from num: Double)-> String{
        var hundredths = Int(num*100)
        let ones = hundredths / 100
        hundredths = hundredths % 100
        if(hundredths == 0){
            return "\(ones)"
        }
        return "\(ones).\(hundredths)"
    }
    func getAverageQualityDouble()->Double{
        if(entries.count == 0){
            return 0
        }
        var quality = 0
        for entry in entries{
            quality += entry.quality
        }
        return (Double)(quality)/(Double)(entries.count)
    }
    func compareQualityAverage(_ value: Double) -> String{
        let average = getAverageQualityDouble()
        let dividend = value/average
        if(dividend > 1){
            let percent = Int((dividend - 1)*100)
            return "\(percent)% higher than average"
        }
        if(dividend < 1){
            let percent = Int((1-dividend)*100)
            return "\(percent)% lower than average"
        }
        return "equal to average"
    }
    func compareProductivityAverage(_ value: Double) -> String{
        let average = getAverageProductivityDouble()
        let dividend = Double(value)/Double(average)
        if(dividend > 1){
            let percent = Int((dividend - 1)*100)
            return "\(percent)% higher than average"
        }
        if(dividend < 1){
            let percent = Int((1-dividend)*100)
            return "\(percent)% lower than average"
        }
        return "equal to average"
    }
    func compareAverage(_ value: Double, _ dependentVariable: DependentVariable) -> String{
        if(dependentVariable == .quality){
            return compareQualityAverage(value)
        }
        if(dependentVariable == .productivity){
            return compareProductivityAverage(value)
        }
        print("Called compare average when dependentvariable is both")
        return compareQualityAverage(value)
    }
    func getAverageProductivityDouble()->Double{
        if(entries.count == 0){
            return 0
        }
        var productivity = 0
        for entry in entries{
            productivity += entry.productivity
        }
        return (Double)(productivity)/(Double)(entries.count)
    }
    
    func getProductivityStandardDeviation()->Double{
        var sum = 0.0
        let average = getAverageProductivityDouble()
        for entry in entries{
            sum += (Double(entry.productivity)-average)*(Double(entry.productivity)-average)
        }
        return sqrt(sum/Double(entries.count))
    }
    func getQualityStandardDeviation()->Double{
        var sum = 0.0
        let average = getAverageQualityDouble()
        for entry in entries{
            sum += (Double(entry.quality)-average)*(Double(entry.quality)-average)
            
        }
        return sqrt(sum/Double(entries.count))
    }
}
