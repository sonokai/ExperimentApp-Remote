//
//  SleeptimeFunctions.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation

extension SleepExperiment{
    func getLeastSleepTimeMinutes() -> Int{
        var least = 100000000
        for entry in entries{
            let minutes = entry.hoursSlept * 60 + entry.minutesSlept
            if(minutes < least){
                least = minutes
            }
        }
        return least
    }
    func getMostSleepTimeMinutes() -> Int{
        var most = 0
        for entry in entries{
            let minutes = entry.hoursSlept * 60 + entry.minutesSlept
            if(minutes > most){
                most = minutes
            }
        }
        return most
    }
    func getSleepTimeRange() -> Int{
        return getMostSleepTimeMinutes()-getLeastSleepTimeMinutes()
    }
    
    func getAppropriateLengthOfChartAxisMarks() -> Int{
        let difference = getMostSleepTimeMinutes() - getLeastSleepTimeMinutes()
        if(difference > 200){
            return 60
        }
        if(difference > 100){
            return 30
        }
        if(difference > 50){
            return 15
        }
        return 5
    }
    //returns average of sleep time interval for a certain dependent variable
    func averageOfSleepTimeInterval(at startingMinutes: Int, for size: Int, dependentVariable: SleepExperiment.DependentVariable) -> Double{
        var sum = 0
        var count = 0
        //scans the entire entries array for bedtimes between the starting minutes and starting minutes + size. if it finds one, it increments count and adds the quality to sum.
        for entry in entries{
            let minutes = entry.hoursSlept*60 + entry.minutesSlept
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
    func entryCountInSleepTimeInterval(at startingMinutes: Int, for size: Int) -> Int{
        var count = 0
        for entry in entries{
            let minutes = entry.hoursSlept*60 + entry.minutesSlept
            if(minutes >= startingMinutes && minutes < startingMinutes + size){
                count += 1
            }
        }
        return count
    }
    //returns the best amount of sleep time
    func getOptimalSleepTimeInterval(size: Int, dependentVariable: SleepExperiment.DependentVariable, lowEndpoint: Int? = nil, highEndpoint: Int? = nil, requiredEntries: Int = 1) -> Result<Date, SleepExperimentError>{
        
        if(entries.count == 0){
            return .failure(SleepExperimentError.noEntries)
        }
        if(getSleepTimeRange()<15){
            return.failure(SleepExperimentError.insufficientRange)
        }
        if(independentVariable == .bedtime || independentVariable == .waketime){
            print("Called get optimal sleeptime interval but independent variable is either bedtime or waketime")
            return .failure(SleepExperimentError.wrongIndependentVariable)
        }
        //first find bounds of our for loop before iterating through it
        var least = getLeastSleepTimeMinutes()
        if let date1 = lowEndpoint {
            least = date1
        }
        var most = getMostSleepTimeMinutes()
        if let date2 = highEndpoint {
            most = date2
        }
        //set up variables to store where the optimal interval is
        var optimalIntervalAverage: Double = 0
        var optimalInterval = least
        
        //iterate through the range, changing the optimal interval if needed. this will find the optimal minute to start with
        if(least+size > most){
            return .failure(SleepExperimentError.intervalExceedsRange)
        }
        var hasFoundInterval = false
        for i in least..<(most-size){
            if(averageOfSleepTimeInterval(at: i, for: size, dependentVariable: dependentVariable) > optimalIntervalAverage){
                if(entryCountInSleepTimeInterval(at: i, for: size) >= requiredEntries){
                    optimalIntervalAverage = averageOfSleepTimeInterval(at: i, for: size, dependentVariable: dependentVariable)
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
        //convert minutes back into date
        
        if let date = Calendar.current.date(bySettingHour: optimalInterval/60, minute: optimalInterval % 60, second: 0, of: Date()){
            return .success(date)
        } else {
            return .failure(SleepExperimentError.dateConversionError)
        }
    }
    func getOptimalSleepTimeInterval(dependentVariable: DependentVariable, requiredEntries: Int = 1,lowEndpoint: Int? = nil, highEndpoint: Int? = nil) ->Result<Date, SleepExperimentError>{
        if(entries.count == 0){
            return .failure(SleepExperimentError.noEntries)
        }
        if(getSleepTimeRange()<30){
            return.failure(SleepExperimentError.insufficientRange)
        }
        if(!(independentVariable == .hoursSlept || independentVariable == .both)){
            print("Called get optimal sleep time interval but independent variable is bedtime or waketime")
            return .failure(SleepExperimentError.wrongIndependentVariable)
        }
        //set up bounds
        var least = getLeastSleepTimeMinutes()
        if let date1 = lowEndpoint {
            least = date1
        }
        var most = getMostSleepTimeMinutes()
        if let date2 = highEndpoint {
            most = date2
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
            if(entryCountInSleepTimeInterval(at: minutes, for: 30) >= requiredEntries){
                let average = averageOfSleepTimeInterval(at: minutes, for: 30, dependentVariable: dependentVariable)
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
    
    
    
    func getMedianSleepTime() -> String{
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
                let minutes = entries[i].hoursSlept * 60 + entries[i].minutesSlept
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
            let minutes = ((entries[0].hoursSlept * 60 + entries[0].minutesSlept) + (entries[1].hoursSlept * 60 + entries[1].minutesSlept))/2
            return dateStringFromMinutesWithoutAMPM(minutes: minutes)
        }
        
        let minutes = entries[0].hoursSlept * 60 + entries[0].minutesSlept
        return dateStringFromMinutesWithoutAMPM(minutes: minutes)
    }
    
    //returns average waketime in string format
    func getAverageSleepTime() -> String{
        if(entries.count == 0){
            return "Needs more data"
        }
        var minutes = 0
        for entry in entries{
            minutes += entry.hoursSlept * 60 + entry.minutesSlept
        }
        let averageminutes: Int = minutes/entries.count
        
        return dateStringFromMinutesWithoutAMPM(minutes: averageminutes)
    }
    func getSleepTimeStandardDeviation() -> (Int, Int){
        var total = 0.0
        let average = getAverageSleepTimeAsSeconds()
        for entry in entries{
            let difference = SleepExperiment.getSleepTimeSeconds(from: entry)-average
            total += difference*difference
        }
        let standardDeviationSeconds = sqrt(total/Double(entries.count))
        let hours = Int(standardDeviationSeconds/3600)
        let minutes = Int(standardDeviationSeconds.truncatingRemainder(dividingBy: 3600))/60
        return (hours, minutes)
    }
    func getAverageSleepTimeAsSeconds() -> Double{
        if(entries.count == 0){
            return 0
        }
        var total = 0.0
        for entry in entries{
            total += SleepExperiment.getSleepTimeSeconds(from: entry)
        }
        return total/Double(entries.count)
    }
    static func getSleepTimeSeconds(from entry: SleepEntry)-> Double{
        return Double(entry.hoursSlept*3600+entry.minutesSlept*60)
    }
    static func getAverageSleepTimeFromEntries(entries: [SleepEntry])-> Date{
        var total = 0.0
        for entry in entries{
            total += Double(entry.hoursSlept * 60 + entry.minutesSlept)
        }
        let averageminutes = total/Double(entries.count)
        
        return Calendar.current.date(bySettingHour: Int(averageminutes/60), minute: Int(averageminutes) % 60, second: 0, of: Date()) ?? Date()
    }
    func compareLastWeekSleepTimeAverage() -> Int{
        if(entries.count<8){
            return 0
        }
        let normal = entries.dropLast(7)
        let lastweek = entries.suffix(7)
        
        var total = 0
        for entry in normal{
            total += entry.hoursSlept*60 + entry.minutesSlept
        }
        let averageMinutesOfNormal = total/normal.count
        
        
        total = 0
        for entry in lastweek{
            total += entry.hoursSlept*60 + entry.minutesSlept
        }
        let averageMinutesOfLastWeek = total/lastweek.count
        
        //print("Average of normal: \(averageMinutesOfNormal), average of lastweek: \(averageMinutesOfLastWeek)")
        return averageMinutesOfLastWeek-averageMinutesOfNormal
    }
    func getPValueOfSleeptimeInterval(interval: Date, size: Int, dependentVariable: DependentVariable) -> Double{
        //an array of the specified dependent variable outside and inside
        //our interval. aka our two samples we will be comparing
        var outsideInterval: [Int] = []
        var insideInterval: [Int] = []
        
        //sort entries into the correct array
        let startingMinutes = SleepExperiment.getMinutes(from: interval)
        for entry in entries{
            let minutes = entry.hoursSlept * 60 + entry.minutesSlept
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
