//
//  WaketimeFunctions.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation
// waketime stats
extension SleepExperiment{
    //returns best time to wake up
    func getOptimalWaketimeInterval(size: Int, dependentVariable: SleepExperiment.DependentVariable, lowEndpoint: Date? = nil, highEndpoint: Date? = nil, requiredEntries: Int = 1) -> Result<Date, SleepExperimentError>{
        if(entries.count == 0){
            return .failure(SleepExperimentError.noEntries)
        }
        if(getWaketimeRange()<15){
            return.failure(SleepExperimentError.insufficientRange)
        }
        if(independentVariable != .waketime && independentVariable != .both){
            return .failure(SleepExperimentError.wrongIndependentVariable)
        }
        //first find bounds of our for loop before iterating through it
        var least = getLeastWaketimeMinutes()
        if let date1 = lowEndpoint {
            least = SleepExperiment.getWaketimeMinutes(from: date1)
        }
        var most = getMostWaketimeMinutes()
        if let date2 = highEndpoint{
            most = SleepExperiment.getWaketimeMinutes(from: date2)
        }
        //set up variables to store where the optimal interval is
        var optimalIntervalAverage: Double = 0
        var optimalInterval = least
        
        if(least+size > most){
            return .failure(SleepExperimentError.intervalExceedsRange)
        }
        //if we don't find a valid interval, then we return an error
        var hasFoundInterval = false
        //iterate through the range, changing the optimal interval if needed. this will find the optimal minute to start at
        for i in least..<(most-size){
            if(averageOfWaketimeInterval(at: i, for: size, dependentVariable: dependentVariable) > optimalIntervalAverage){
                if(entryCountInWaketimeInterval(at: i, for: size) >= requiredEntries){
                    optimalIntervalAverage = averageOfWaketimeInterval(at: i, for: size, dependentVariable: dependentVariable)
                    optimalInterval = i
                    hasFoundInterval = true
                }
            }
        }
        //edge case
        if (least + size == most){
            optimalInterval = least
        }else if(!hasFoundInterval){
            return .failure(SleepExperimentError.insufficientEntriesInInterval)
        }
        if let date = Calendar.current.date(bySettingHour: optimalInterval/60, minute: optimalInterval % 60, second: 0, of: Date()){
            return .success(date)
        } else {
            return .failure(SleepExperimentError.dateConversionError)
        }
    }
    func getOptimalWaketimeInterval(dependentVariable: DependentVariable, requiredEntries: Int = 1,lowEndpoint: Date? = nil, highEndpoint: Date? = nil) ->Result<Date, SleepExperimentError>{
        if(entries.count == 0){
            return .failure(SleepExperimentError.noEntries)
        }
        if(getWaketimeRange()<30){
            return.failure(SleepExperimentError.insufficientRange)
        }
        if(!(independentVariable == .waketime || independentVariable == .both)){
            print("Called get optimal waketime interval but independent variable is not bedtime")
            return .failure(SleepExperimentError.wrongIndependentVariable)
        }
        //set up bounds
        var least = getLeastWaketimeMinutes()
        if let date1 = lowEndpoint {
            least = SleepExperiment.getWaketimeMinutes(from: date1)
        }
        var most = getMostWaketimeMinutes()
        if let date2 = highEndpoint{
            most = SleepExperiment.getWaketimeMinutes(from: date2)
        }
        
        //iterate through the range, changing the optimal interval if needed. this will find the optimal minute to start with
        if(least+30 > most){
            return .failure(SleepExperimentError.intervalExceedsRange)
        }
        //cycle through these and see which one is the best
        var bestMinutes = -1
        var bestAverage :Double = 0
        var hasFoundOptimalInterval = false
        
        for minutes in stride(from: 0, through: 1440, by: 30){
            if(minutes < least || minutes + 30 > most){
                continue
            }
            if(entryCountInWaketimeInterval(at: minutes, for: 30) >= requiredEntries){
                let average = averageOfWaketimeInterval(at: minutes, for: 30, dependentVariable: dependentVariable)
                if(average > bestAverage){
                    bestAverage = average
                    bestMinutes = minutes
                    hasFoundOptimalInterval = true
                }
            }
        }
        if(!hasFoundOptimalInterval){
            return .failure(SleepExperimentError.insufficientEntriesInInterval)
        }
        
        if let date = Calendar.current.date(bySettingHour: bestMinutes/60, minute: bestMinutes % 60, second: 0, of: Date()){
            return .success(date)
        } else {
            return .failure(SleepExperimentError.dateConversionError)
        }
    }
    func entryCountInWaketimeInterval(at startingMinutes: Int, for size: Int) -> Int{
        var count = 0
        for entry in entries{
            let minutes = SleepExperiment.getWaketimeMinutes(from: entry.waketime)
            if(minutes >= startingMinutes && minutes < startingMinutes + size){
                count += 1
            }
        }
        return count
    }
    func getLeastWaketimeMinutes() -> Int{
        var least = 100000000
        for entry in entries{
            let minutes = SleepExperiment.getWaketimeMinutes(from: entry.waketime)
            if(minutes < least){
                least = minutes
            }
        }
        return least
    }
    func getMostWaketimeMinutes() -> Int{
        var most = 0
        for entry in entries{
            let minutes = SleepExperiment.getWaketimeMinutes(from: entry.waketime)
            if(minutes > most){
                most = minutes
            }
        }
        return most
    }
    static func getWaketimeSeconds(from date: Date)-> Double{
        let minutes = getWaketimeMinutes(from: date)
        return Double(minutes) * 60
    }
    func getWaketimeRange() -> Int{
        return getMostWaketimeMinutes()-getLeastWaketimeMinutes()
    }
    
    // returns average of waketime interval for a certain dependent variable
    func averageOfWaketimeInterval(at startingMinutes: Int, for size: Int, dependentVariable: SleepExperiment.DependentVariable) -> Double{
        var sum = 0
        var count = 0
        //scans the entire entries array for bedtimes between the starting minutes and starting minutes + size. if it finds one, it increments count and adds the quality to sum.
        for entry in entries{
            let minutes = SleepExperiment.getWaketimeMinutes(from: entry.waketime)
            if(minutes >= startingMinutes && minutes < startingMinutes + size){
                if(dependentVariable == .quality){
                    sum += entry.quality
                }
                if(dependentVariable == .productivity){
                    sum += entry.productivity
                }
                
                count += 1
            }
            
        }
     
        if(count == 0){
            return 0
        }
        return (Double)(sum)/(Double)(count)
    }
    
    //returns average waketime in string format
    func getAverageWaketime() -> String{
        var minutes = 0
        for entry in entries{
            minutes += SleepExperiment.getMinutes(from: entry.waketime)
        }
        let averageminutes: Int = minutes/entries.count
        
        return dateStringFromMinutes(minutes: averageminutes)
    }
    func getMedianWaketime() -> String{
        if(entries.count == 0){
            return "Needs more data"
        }
        var entries = self.entries
        
        //remove the max and the min as long as entries size is more than 2
        while(entries.count>2){
            var most = 0
            var least = 10000000
            var mostIndex = 0
            var leastIndex = 0
            for i in 0..<entries.count{
                let minutes = SleepExperiment.getMinutes(from: entries[i].waketime)
                if(minutes>most){
                    most = minutes
                    mostIndex = i
                } else if(minutes<least){
                    least = minutes
                    leastIndex = i
                }
            }
            //note that if we remove the smaller index first, the larger index will remove what we did not initially intend for it to remove
            //so we will remove the larger index first
            //also note that if the remaining values are all the same,
            //mostIndex = leastIndex = entries.count-1
            //in that case (the else case), we remove the last two items in entries
            if(mostIndex<leastIndex){
                entries.remove(at: leastIndex)
                entries.remove(at: mostIndex)
            }else if (leastIndex<mostIndex){
                entries.remove(at: mostIndex)
                entries.remove(at: leastIndex)
            }else {
                entries.remove(at: mostIndex)
                entries.remove(at: mostIndex-1)
            }
        }
        //if there are a final two, mean the last two and return, otherwise, return the last
        if(entries.count == 2){
            let minutes = (SleepExperiment.getMinutes(from: entries[0].waketime) + SleepExperiment.getMinutes(from: entries[1].waketime))/2
            return dateStringFromMinutes(minutes: minutes)
        }
        
        let minutes = SleepExperiment.getMinutes(from: entries[0].waketime)
        return dateStringFromMinutes(minutes: minutes)
    }
    //This should only return from 0 to 1440
    static func getWaketimeMinutes(from date: Date)-> Int {
        let time = getHoursAndMinute(from: date)
        return time.0*60+time.1
        
    }
    static func getAverageWaketimeFromEntries(entries: [SleepEntry])-> Date{
        var total = 0.0
        for entry in entries{
            total += Double(SleepExperiment.getWaketimeMinutes(from: entry.waketime))
        }
        let averageminutes = total/Double(entries.count)
        
        return Calendar.current.date(bySettingHour: Int(averageminutes/60), minute: Int(averageminutes) % 60, second: 0, of: Date()) ?? Date()
    }
    
    func getAverageWaketimeAsSeconds() -> Double{
        if(entries.count == 0){
            return 0
        }
        var total = 0.0
        for entry in entries{
            total += SleepExperiment.getWaketimeSeconds(from: entry.waketime)
        }
        return total/Double(entries.count)
    }
    func compareLastWeekWaketimeAverage() -> Int{
        if(entries.count<8){
            return 0
        }
        let normal = entries.dropLast(7)
        let lastweek = entries.suffix(7)
        
        var total = 0
        for entry in normal{
            total += SleepExperiment.getWaketimeMinutes(from: entry.waketime)
        }
        let averageMinutesOfNormal = total/normal.count
        
        
        total = 0
        for entry in lastweek{
            total += SleepExperiment.getWaketimeMinutes(from: entry.waketime)
        }
        let averageMinutesOfLastWeek = total/lastweek.count
        
        //print("Average of normal: \(averageMinutesOfNormal), average of lastweek: \(averageMinutesOfLastWeek)")
        return averageMinutesOfLastWeek-averageMinutesOfNormal
    }
    func getWaketimeStandardDeviation() -> (Int, Int){
        var total = 0.0
        let average = getAverageWaketimeAsSeconds()
        for entry in entries{
            let difference = SleepExperiment.getWaketimeSeconds(from: entry.waketime)-average
            total += difference*difference
        }
        let standardDeviationSeconds = sqrt(total/Double(entries.count))
        let hours = Int(standardDeviationSeconds/3600)
        let minutes = Int(standardDeviationSeconds.truncatingRemainder(dividingBy: 3600))/60
        return (hours, minutes)
    }
    
    //see getpValueofbedtimeinterval and replace bed with wake
    func getPValueOfWaketimeInterval(interval: Date, size: Int, dependentVariable: DependentVariable) -> Double{
        var outsideInterval: [Int] = []
        var insideInterval: [Int] = []
        let startingMinutes = SleepExperiment.getWaketimeMinutes(from: interval)
        for entry in entries{
            let minutes = SleepExperiment.getWaketimeMinutes(from: entry.waketime)
            if(minutes >= startingMinutes && minutes < startingMinutes + size){
                if(dependentVariable == .quality){
                    insideInterval.append(entry.quality)
                } else {
                    insideInterval.append(entry.productivity)
                }
            }else {
                if(dependentVariable == .quality){
                    outsideInterval.append(entry.quality)
                } else {
                    outsideInterval.append(entry.productivity)
                }
            }
        }
        return StatsTable.twoSampleTTest(array1: insideInterval, array2: outsideInterval)
    }
    
    
    
}
