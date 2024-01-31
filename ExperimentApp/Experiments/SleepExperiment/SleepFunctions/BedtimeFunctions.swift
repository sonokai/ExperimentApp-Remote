//
//  BedtimeFunctions.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation
extension SleepExperiment{
    //returns the best time to sleep, given an interval size, a dependent variable to optimize, a lower endpoint, a higher endpoint, and
    // a minimum number of entries the best interval must have
    //not formatted for chart
    func getOptimalBedtimeInterval(size: Int, dependentVariable: SleepExperiment.DependentVariable, lowEndpoint: Date? = nil, highEndpoint: Date? = nil, requiredEntries: Int = 1) -> Result<Date, SleepExperimentError>{
        if(entries.count == 0){
            return .failure(SleepExperimentError.noEntries)
        }
        if(getBedtimeRange()<15){
            return.failure(SleepExperimentError.insufficientRange)
        }
        if(!(independentVariable == .bedtime || independentVariable == .both)){
            print("Called get optimal bedtime interval but independent variable is not bedtime")
            return .failure(SleepExperimentError.wrongIndependentVariable)
        }
        
        
        //first find bounds of our for loop before iterating through it
        var least = getLeastBedtimeMinutes()
        if let date1 = lowEndpoint {
            least = SleepExperiment.getBedtimeMinutes(from: date1)
        }
        
        var most = getMostBedtimeMinutes()
        if let date2 = highEndpoint{
            most = SleepExperiment.getBedtimeMinutes(from: date2)
        }
        //set up variables to store where the optimal interval is
        var optimalIntervalAverage: Double = 0
        var optimalInterval = least
        
        //iterate through the range, changing the optimal interval if needed. this will find the optimal minute to start with
        if(least+size > most){
            return .failure(SleepExperimentError.intervalExceedsRange)
        }
        //if we don't find a valid interval, then we return an error
        var hasFoundInterval = false
        for i in least..<(most-size){
            if(isValidOptimalInterval(bedtimeMinutes: i, size: size, dependentVariable: dependentVariable, optimalIntervalAverage: optimalIntervalAverage, requiredEntries: requiredEntries)){
                optimalIntervalAverage = averageOfBedtimeInterval(at: i, for: size, dependentVariable: dependentVariable)
                optimalInterval = i
                hasFoundInterval = true
            }
        }
        //edge case
        if (least + size == most){
            optimalInterval = least
        }else if(!hasFoundInterval){
            return .failure(SleepExperimentError.insufficientEntriesInInterval)
        }
        
        if(optimalInterval >= 1440){
            optimalInterval = optimalInterval - 1440
        }
        if let date = Calendar.current.date(bySettingHour: optimalInterval/60, minute: optimalInterval % 60, second: 0, of: Date()){
            return .success(date)
        } else {
            return .failure(SleepExperimentError.dateConversionError)
        }
    }
    
    //the same but fixed size so that it always lands on a nice number
    func getOptimalBedtimeInterval(dependentVariable: DependentVariable, requiredEntries: Int = 1,lowEndpoint: Date? = nil, highEndpoint: Date? = nil) ->Result<Date, SleepExperimentError>{
        if(entries.count == 0){
            return .failure(SleepExperimentError.noEntries)
        }
        if(getBedtimeRange()<30){
            return.failure(SleepExperimentError.insufficientRange)
        }
        if(!(independentVariable == .bedtime || independentVariable == .both)){
            print("Called get optimal bedtime interval but independent variable is not bedtime")
            return .failure(SleepExperimentError.wrongIndependentVariable)
        }
        //set up bounds
        var least = getLeastBedtimeMinutes()
        if let date1 = lowEndpoint {
            least = SleepExperiment.getBedtimeMinutes(from: date1)
        }
        var most = getMostBedtimeMinutes()
        if let date2 = highEndpoint{
            most = SleepExperiment.getBedtimeMinutes(from: date2)
        }
        
        //iterate through the range, changing the optimal interval if needed. this will find the optimal minute to start with
        if(least+30 > most){
            return .failure(SleepExperimentError.intervalExceedsRange)
        }
        //cycle through these and see which one is the best
        var bestMinutes = -1
        var bestAverage :Double = 0
        var hasFoundOptimalInterval = false
        for minutes in stride(from: 720, through: 2160, by: 30){
            if(minutes < least || minutes + 30 > most){
                continue
            }
            if(entryCountInBedtimeInterval(at: minutes, for: 30) >= requiredEntries){
                let average = averageOfBedtimeInterval(at: minutes, for: 30, dependentVariable: dependentVariable)
                if(average > bestAverage){
                    bestAverage = average
                    bestMinutes = minutes
                    hasFoundOptimalInterval = true
                }
            }
        }
        if(bestMinutes >= 1440){
            bestMinutes = bestMinutes - 1440
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
    //returns whether or not a bedtime interval (starting minutes and size)
    //is valid for a certain dependent variable
    //validity: it needs to be greater than the prior optimal average, and also have the required entry count
    func isValidOptimalInterval(bedtimeMinutes: Int, size: Int, dependentVariable: DependentVariable, optimalIntervalAverage: Double, requiredEntries: Int) -> Bool{
        if(averageOfBedtimeInterval(at: bedtimeMinutes, for: size, dependentVariable: dependentVariable) > optimalIntervalAverage){
            if(entryCountInBedtimeInterval(at: bedtimeMinutes, for: size) >= requiredEntries){
                return true
            }
        }
        return false
    }
    static func getHoursAndMinute(from date: Date) -> (Int, Int){
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        guard let hour = components.hour else {
            fatalError("Failed to extract")
        }
        let calendar1 = Calendar.current
        let components1 = calendar1.dateComponents([.minute], from: date)
        guard let minute = components1.minute else {
            fatalError("Failed to extract")
        }
        return (hour, minute)
    }
    //returns the converted minutes from a date (if part of AM, it counts as the second day)
    static func getBedtimeMinutes(from date: Date)-> Int {
        let time = getHoursAndMinute(from: date)
        var minutes = time.0*60+time.1
        //if AM, consider it to be the next day
        if(minutes<720){
            minutes += 1440
        }
        return minutes
    }
    static func getBedtimeSeconds(from date: Date)-> Double{
        let seconds = Double(getBedtimeMinutes(from: date)*60)
        //if am, pass it at the next day
        if(seconds<43_200){
            return seconds + 86_400
        }
        return seconds
    }
    static func getMinutes(from date: Date)-> Int {
        let time = getHoursAndMinute(from: date)
        return time.0*60+time.1
    }
    //changed bedtime
    func getLeastBedtimeMinutes() -> Int{
        var least = 100000000
        for entry in entries{
            let minutes = SleepExperiment.getBedtimeMinutes(from: entry.bedtime)
            if(minutes < least){
                least = minutes
            }
        }
        return least
    }
    //changed bedtime
    func getMostBedtimeMinutes() -> Int{
        var most = 0
        for entry in entries{
            let minutes = SleepExperiment.getBedtimeMinutes(from: entry.bedtime)
            if(minutes > most){
                most = minutes
            }
        }
        return most
    }
    func getBedtimeRange() -> Int{
        return getMostBedtimeMinutes()-getLeastBedtimeMinutes()
    }
    
    
    //returns average of bedtime interval for a certain dependent variable
    func averageOfBedtimeInterval(at startingMinutes: Int, for size: Int, dependentVariable: SleepExperiment.DependentVariable) -> Double{
        var sum = 0
        var count = 0
        //scans the entire entries array for bedtimes between the starting minutes and starting minutes + size. if it finds one, it increments count and adds the quality to sum.
        for entry in entries{
            let minutes = SleepExperiment.getBedtimeMinutes(from: entry.bedtime)
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
    
    func entryCountInBedtimeInterval(at startingMinutes: Int, for size: Int) -> Int{
        var count = 0
        for entry in entries{
            let minutes = SleepExperiment.getBedtimeMinutes(from: entry.bedtime)
            if(minutes >= startingMinutes && minutes < startingMinutes + size){
                count += 1
            }
        }
        return count
    }
    
    //takes in an interval (Date) with size, a dependent variable of either
    //quality of productivity to run the test on
    //and returns the confidence
    //that it is better than the rest of the data
    //uses a two sample t test
    func getPValueOfBedtimeInterval(interval: Date, size: Int, dependentVariable: DependentVariable) -> Double{
        //an array of the specified dependent variable outside and inside
        //our interval. aka our two samples we will be comparing
        var outsideInterval: [Int] = []
        var insideInterval: [Int] = []
        
        //sort entries into the correct array
        let startingMinutes = SleepExperiment.getBedtimeMinutes(from: interval)
        for entry in entries{
            let minutes = SleepExperiment.getBedtimeMinutes(from: entry.bedtime)
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
    
    //returns average bedtime in string format
    func getAverageBedtime() -> String{
        
        if (entries.count == 0){
            return "No entries"
        }
        var total = 0
        for entry in entries{
            total += SleepExperiment.getBedtimeMinutes(from: entry.bedtime)
        }
        
        let averageminutes: Int = total/entries.count
        //since AM averages are in the next day, bring it back to the present day to convert to string
        return dateStringFromMinutes(minutes: averageminutes)
    }
    //returns average bedtime from a entry array
    //in the form of date
    //not plottable since the day isnt adjusted for am pm
    static func getAverageBedtimeFromEntries(entries: [SleepEntry])-> Date{
        var total = 0.0
        for entry in entries{
            total += Double(SleepExperiment.getBedtimeMinutes(from: entry.bedtime))
        }
        var averageminutes = total/Double(entries.count)
        if(averageminutes > 1440){
            averageminutes = averageminutes - 1440
        }
       
        
        return Calendar.current.date(bySettingHour: Int(averageminutes/60), minute: Int(averageminutes) % 60, second: 0, of: Date()) ?? Date()
    }
    func getAverageBedtimeAsSeconds() -> Double{
        if(entries.count == 0){
            return 0
        }
        var total = 0.0
        for entry in entries{
            total += SleepExperiment.getBedtimeSeconds(from: entry.bedtime)
        }
        return total/Double(entries.count)
    }
    //compares last week's average bedtime with the rest and returns minutes
    //if not enough data, returns 0
    func compareLastWeekBedtimeAverage() -> Int{
        if(entries.count<8){
            return 0
        }
        let normal = entries.dropLast(7)
        let lastweek = entries.suffix(7)
        
        var total = 0
        for entry in normal{
            total += SleepExperiment.getBedtimeMinutes(from: entry.bedtime)
        }
        let averageMinutesOfNormal = total/normal.count
        
        
        total = 0
        for entry in lastweek{
            total += SleepExperiment.getBedtimeMinutes(from: entry.bedtime)
        }
        let averageMinutesOfLastWeek = total/lastweek.count
        
        //print("Average of normal: \(averageMinutesOfNormal), average of lastweek: \(averageMinutesOfLastWeek)")
        return averageMinutesOfLastWeek-averageMinutesOfNormal
    }
    //returns hour and minute of standard deviation of bedtime
    func getBedtimeStandardDeviation() -> (Int, Int){
        var total = 0.0
        let average = getAverageBedtimeAsSeconds()
        for entry in entries{
            let difference = SleepExperiment.getBedtimeSeconds(from: entry.bedtime)-average
            total += difference*difference
        }
        let standardDeviationSeconds = sqrt(total/Double(entries.count))
        let hours = Int(standardDeviationSeconds/3600)
        let minutes = Int(standardDeviationSeconds.truncatingRemainder(dividingBy: 3600))/60
        return (hours, minutes)
    }
    
    func getMedianBedtime() -> String{
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
                let minutes = SleepExperiment.getBedtimeMinutes(from: entries[i].bedtime)
                if(minutes>most){
                    most = minutes
                    mostIndex = i
                }
                if(minutes<least){
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
            let minutes = (SleepExperiment.getBedtimeMinutes(from: entries[0].bedtime) + SleepExperiment.getBedtimeMinutes(from: entries[1].bedtime))/2
            print("there are two middle numbers: \(dateStringFromMinutes(minutes: SleepExperiment.getBedtimeMinutes(from: entries[0].bedtime))) and  \(dateStringFromMinutes(minutes: SleepExperiment.getBedtimeMinutes(from: entries[1].bedtime)))")
            return dateStringFromMinutes(minutes: minutes)
            
        }
        
        let minutes = SleepExperiment.getBedtimeMinutes(from: entries[0].bedtime)
        return dateStringFromMinutes(minutes: minutes)
    }
}
