//
//  SleepExperiment.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/3/23.
//

import Foundation

struct SleepExperiment: Identifiable, Codable{
    let id: UUID
    let goalEntries: Int //ask user how many entries they want to have
    let dependentVariable: DependentVariable //ask user if they want to track how sleep affects their productivity or quality of day
    let independentVariable: IndependentVariable //ask user if they want to guess how much hours they slept on their own or only track bedtime, waketime, or both bedtime and waketime for the maximum data
    var entries: [SleepEntry] = []
    var notes: String = "Take notes here"
    var name: String = "Sleep Experiment"
    
    
    init(id: UUID = UUID(), goalEntries: Int, dependentVariable: DependentVariable, independentVariable: IndependentVariable) {
        self.id = id
        self.goalEntries = goalEntries
        self.dependentVariable = dependentVariable
        self.independentVariable = independentVariable
    }
    //for testing
    init(id: UUID = UUID(), goalEntries: Int, dependentVariable: DependentVariable, independentVariable: IndependentVariable, entries: [SleepEntry], name: String, notes: String) {
        self.id = id
        self.goalEntries = goalEntries
        self.dependentVariable = dependentVariable
        self.independentVariable = independentVariable
        self.entries = entries
        self.name = name
        self.notes = notes
    }
}
extension SleepExperiment{
    enum DependentVariable: String, Codable, CaseIterable, Identifiable{
        var id: Self{
            return self
        }
        case productivity = "Productivity"
        case quality = "Quality"
        case both = "both"
        
        var name: String {
            rawValue.capitalized
        }
    }
    enum IndependentVariable: String, Codable, CaseIterable, Identifiable{
        var id: Self {
            return self
        }
        case bedtime = "Bedtime"
        case waketime = "Waketime"
        case both = "Both"
        case hoursSlept = "Hours slept"
        
        var name: String {
            rawValue.capitalized
        }
    }
}

extension SleepExperiment{
    
    func getTitle() -> String{
        var string1 = ""
        switch(self.independentVariable){
            case .bedtime: string1 = "Bedtime"
            case .waketime: string1 = "Wake time"
            case .both: string1 = "Both Bedtime and Waketime"
            case .hoursSlept: string1 = "Hours slept "
        }
        var string2 = ""
        switch(self.dependentVariable){
            case .quality: string2 = "Quality of day"
            case .productivity: string2 = "Productivity"
            case .both: string2 = "Quality of day and Productivity"
        }
        
        return string1 + " vs. " + string2
    }
    func getChartTitle(buttonValue: String, independentVariable: IndependentVariable) -> String{
        if(dependentVariable == .both){
            switch(buttonValue){
            case "none":
                return "Loading chart..."
            case "quality":
                return "\(independentVariable.rawValue) vs. quality of day"
            case "productivity":
                return "\(independentVariable.rawValue) vs. productivity"
            case "compare":
                return "\(independentVariable.rawValue) vs. quality of day and productivity"
            default:
                return "AHHHHH IT broke "
            }
        
        }else{
            return self.getTitle()
        }

    }
}

// bedtime stats
extension SleepExperiment{
    //returns the best time to sleep
    func getOptimalBedtimeInterval(size: Int, dependentVariable: SleepExperiment.DependentVariable) -> Date?{
        if(entries.count == 0){
            return nil
        }
        if(independentVariable != .bedtime){
            print("Called get optimal bedtime interval but independent variable is not bedtime")
            return nil
        }
        //first find bounds of our for loop before iterating through it
        let least = getLeastBedtimeMinutes()
        let most = getMostBedtimeMinutes()
        //set up variables to store where the optimal interval is
        var optimalIntervalAverage: Double = 0
        var optimalInterval = least
        
        //iterate through the range, changing the optimal interval if needed. this will find the optimal minute to start with
        if(least+size > most){
            print("least is \(least) but most is \(most)")
            return nil
        }
        for i in least..<(most-size){
            if(averageOfBedtimeInterval(at: i, for: size, dependentVariable: dependentVariable) > optimalIntervalAverage){
                optimalIntervalAverage = averageOfBedtimeInterval(at: i, for: size, dependentVariable: dependentVariable)
                optimalInterval = i
            }
            
        }
        //convert minutes back into date
        var day = 1
        if(optimalInterval > 1440){
            optimalInterval = optimalInterval - 1440
            day = 2
        }
        
        return Calendar.current.date(bySettingHour: optimalInterval/60, minute: optimalInterval % 60, second: 0, of: Date(timeIntervalSinceReferenceDate: TimeInterval(day * 24 * 3600)))
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
    
    static func getBedtimeMinutes(from date: Date)-> Int {
        let time = getHoursAndMinute(from: date)
        var minutes = time.0*60+time.1
        //if AM, consider it to be the next day
        if(minutes<720){
            minutes += 1440
        }
        return minutes
    }
    
    static func getMinutes(from date: Date)-> Int {
        let time = getHoursAndMinute(from: date)
        return time.0*60+time.1
    }
    
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
    
    
    
    func getMedianBedtime() -> String{
        if(entries.count == 0){
            return "Needs more data"
        }
        var entries = self.entries
        
        //remove the max and the min as long as entries size is more than 2
        while(entries.count>2){
            var most = 0
            var least = 10000000
            var mostIndex = -1
            var leastIndex = -1
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
            //print("leastIndex: \(leastIndex)")
            //print("mostIndex: \(mostIndex)")
            //print("removed \(dateStringFromMinutes(minutes: SleepExperiment.getBedtimeMinutes(from: entries[leastIndex].bedtime)))")
            //print("removed \(dateStringFromMinutes(minutes:SleepExperiment.getBedtimeMinutes(from: entries[mostIndex].bedtime)))")
            //print("Entries left: \(entries.count-2)")
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
    func dateStringFromMinutes(minutes: Int) -> String{
        if let date = Calendar.current.date(bySettingHour: minutes/60, minute: minutes % 60, second: 0, of: Date()){
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.dateFormat = "H:mm a"
            return dateFormatter.string(from: date)
        } else {
            if let date2 = Calendar.current.date(bySettingHour: ((minutes/60)-24), minute: minutes % 60, second: 0, of: Date()){
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .short
                dateFormatter.dateFormat = "H:mm a"
                return dateFormatter.string(from: date2)
            }
            else{
                return "I broke"
            }
        }
    }
    
}
// waketime stats
extension SleepExperiment{
    //returns best time to wake up
    func getOptimalWaketimeInterval(size: Int, dependentVariable: SleepExperiment.DependentVariable) -> Date?{
        if(entries.count == 0){
            return nil
        }
        if(independentVariable != .waketime){
            print("This is a waketime interval and you're not using the right method")
            return nil
        }
        //first find bounds of our for loop before iterating through it
        let least = getLeastWaketimeMinutes()
        let most = getMostWaketimeMinutes()
        //set up variables to store where the optimal interval is
        var optimalIntervalAverage: Double = 0
        var optimalInterval = least
        
        //iterate through the range, changing the optimal interval if needed. this will find the optimal minute to start at
        for i in least..<(most-size){
            if(averageOfWaketimeInterval(at: i, for: size, dependentVariable: dependentVariable) > optimalIntervalAverage){
                optimalIntervalAverage = averageOfWaketimeInterval(at: i, for: size, dependentVariable: dependentVariable)
                optimalInterval = i
            }
           
        }
        // next convert minutes back into a date
        return Calendar.current.date(bySettingHour: optimalInterval/60, minute: optimalInterval % 60, second: 0, of: Date())
        
    }
    func getLeastWaketimeMinutes() -> Int{
        var least = 100000000
        for entry in entries{
            let minutes = SleepExperiment.getMinutes(from: entry.waketime)
            if(minutes < least){
                least = minutes
            }
        }
        return least
    }
    func getMostWaketimeMinutes() -> Int{
        var most = 0
        for entry in entries{
            let minutes = SleepExperiment.getMinutes(from: entry.waketime)
            if(minutes > most){
                most = minutes
            }
        }
        return most
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
            let minutes = SleepExperiment.getMinutes(from: entry.waketime)
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
            var mostIndex = -1
            var leastIndex = -1
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
    
}
//sleep time stats
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
    //returns the best amount of sleep time
    func getOptimalSleepTimeInterval(size: Int, dependentVariable: SleepExperiment.DependentVariable) -> Date?{
        if(entries.count == 0){
            return nil
        }
        if(independentVariable == .bedtime || independentVariable == .waketime){
            print("Called get optimal sleeptime interval but independent variable is either bedtime or waketime")
            return nil
        }
        //first find bounds of our for loop before iterating through it
        let least = getLeastSleepTimeMinutes()
        let most = getMostSleepTimeMinutes()
        //set up variables to store where the optimal interval is
        var optimalIntervalAverage: Double = 0
        var optimalInterval = least
        
        //iterate through the range, changing the optimal interval if needed. this will find the optimal minute to start with
        for i in least..<(most-size){
            if(averageOfSleepTimeInterval(at: i, for: size, dependentVariable: dependentVariable) > optimalIntervalAverage){
                optimalIntervalAverage = averageOfSleepTimeInterval(at: i, for: size, dependentVariable: dependentVariable)
                optimalInterval = i
            }
            
        }
        //convert minutes back into date
        
        return Calendar.current.date(bySettingHour: optimalInterval/60, minute: optimalInterval % 60, second: 0, of: Date())
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
            var mostIndex = -1
            var leastIndex = -1
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
            return dateStringFromMinutes(minutes: minutes)
        }
        
        let minutes = entries[0].hoursSlept * 60 + entries[0].minutesSlept
        return dateStringFromMinutes(minutes: minutes)
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
        
        return dateStringFromMinutes(minutes: averageminutes)
    }
    
}
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

}
