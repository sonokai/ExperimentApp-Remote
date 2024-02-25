//
//  SleepEntry.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/28/23.
//

import Foundation

struct SleepEntry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var bedtime: Date
    var waketime: Date
    var quality: Int
   // var timeSlept: String
    var productivity: Int
    var hoursSlept: Int = 0
    var minutesSlept: Int = 0
    
    init(id: UUID = UUID(), date: Date, bedtime: Date, waketime: Date = Date(), quality: Int) { //both bedtime and waketime, quality
        self.id = id
        self.date = date
        self.bedtime = bedtime
        self.waketime = waketime
        self.quality = quality
       // self.timeSlept = "0"
        self.productivity = 1
    }
    
    /// allows for initialization no matter the independent and dependent variables stated
    init(id: UUID = UUID(), date: Date, bedtime: Date = Date(), waketime: Date = Date(), timeSlept: String = "", quality: Int = 1, productivity: Int = 1, hoursSlept: Int = 1, minutesSlept: Int = 1) {
        self.id = id
        self.date = date
        self.bedtime = bedtime
        self.waketime = waketime
        self.quality = quality
        self.productivity = productivity
       // self.timeSlept = timeSlept
        self.hoursSlept = hoursSlept
        self.minutesSlept = minutesSlept
    }
    
    init(newEntry: NewSleepEntry){
        self.id = UUID()
        self.date = newEntry.date
        //we will use a work around to make sure we can plot the same bedtime many times, by using the seconds to make unique bedtimes
        //note that if we don't the thing will crash
        if let bedtime = newEntry.bedtime{
            self.bedtime = bedtime
        } else{
            bedtime = Date()
        }
        
        if let waketime = newEntry.waketime{
            self.waketime = waketime
        } else {
            waketime = Date()
        }
        /*
        if let bedtime = newEntry.bedtime, let waketime = newEntry.waketime{
            let (hour, minute) = SleepEntry.returnTimeSlept(sleep: bedtime, wake: waketime)
            self.hoursSlept = hour
            self.minutesSlept = minute
        }*/
        
        if let quality = newEntry.quality{
            self.quality = quality
        } else {
            quality = 5
        }
        
        if let productivity = newEntry.productivity{
            self.productivity = productivity
        } else {
            productivity = 5
        }
        
        if let hours = newEntry.hoursSlept{
            self.hoursSlept = hours
            self.minutesSlept = 0
        }
        
        if let minutes = newEntry.minutesSlept{
            self.minutesSlept = minutes
        } 
      //  self.timeSlept = "0"
    }
    
    
    static func calculateTimeSlept(sleep: Date, wake: Date) -> (String){
        let sleepHour = getHour(date: sleep)
        let sleepMinute = getMinute(date: sleep)
        let wakeHour = getHour(date: wake)
        let wakeMinute = getMinute(date:wake)
        //assume that if wakehour is less than sleep hour, you're crossing over a 12 once
        var minuteDifference = wakeMinute - sleepMinute
        var hourDifference = wakeHour - sleepHour
        
        
        if(minuteDifference<0){
            minuteDifference = minuteDifference + 60
            hourDifference = hourDifference - 1
        }
        if(hasSameAMPM(date1: sleep, date2: wake)){
            if(hourDifference<0){
                hourDifference += 24
            }
        } else {
            if(hourDifference<=0){
                hourDifference += 24
            }
        }
        if(minuteDifference == 0){
            return "\(hourDifference) hours, \(minuteDifference) minutes "
        }
        return "\(hourDifference) hours, \(minuteDifference) minutes"
    }
    static func returnTimeSlept(sleep: Date, wake: Date) -> (Int, Int){
        let sleepHour = getHour(date: sleep)
        let sleepMinute = getMinute(date: sleep)
        let wakeHour = getHour(date: wake)
        let wakeMinute = getMinute(date:wake)
        //assume that if wakehour is less than sleep hour, you're crossing over a 12 once
        var minuteDifference = wakeMinute - sleepMinute
        var hourDifference = wakeHour - sleepHour
        
        
        if(minuteDifference<0){
            minuteDifference = minuteDifference + 60
            hourDifference = hourDifference - 1
        }
        if(hasSameAMPM(date1: sleep, date2: wake)){
            if(hourDifference<0){
                hourDifference += 24
            }
        } else {
            if(hourDifference<=0){
                hourDifference += 24
            }
        }
        return (hourDifference, minuteDifference)
    }
    static func getHour(date: Date) -> (Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        guard let hour = components.hour else {
            fatalError("Failed to extract")
        }
        return hour
    }
    static func getMinute(date: Date) -> (Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date)
        guard let minute = components.minute else {
            fatalError("Failed to extract")
        }
        return minute
    }
    static func hasSameAMPM(date1: Date, date2: Date)-> (Bool){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: date1) == dateFormatter.string(from: date2)
    }
    
}


extension SleepEntry {
    
    static func createDate(month: Int, day: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
    static let sampleData: [SleepEntry] =
    [
        
       // SleepEntry(date: createDate(month: 10, day: 1, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!, quality: 5),
        SleepEntry(date: createDate(month: 10, day: 2, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!, quality: 6),
        
        SleepEntry(date: createDate(month: 10, day: 3, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date())!, quality: 7),
        
        SleepEntry(date: createDate(month: 10, day: 4, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 10, second: 0, of: Date())!, quality: 6),
        
        SleepEntry(date: createDate(month: 10, day: 5, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 11, minute: 20, second: 0, of: Date())!, quality: 7),
        SleepEntry(date: createDate(month: 10, day: 6, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 40, second: 0, of: Date())!, quality: 5),
        SleepEntry(date: createDate(month: 10, day: 7, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 50, second: 0, of: Date())!, quality: 7),
        SleepEntry(date: createDate(month: 10, day: 8, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 20, second: 0, of: Date())!, quality: 6),
        SleepEntry(date: createDate(month: 10, day: 9, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 9, minute: 40, second: 0, of: Date())!, quality: 5),
        
        SleepEntry(date: createDate(month: 10, day: 10, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 9, minute: 45, second: 0, of: Date())!, quality: 4),
        SleepEntry(date: createDate(month: 10, day: 11, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!, quality: 9),
        SleepEntry(date: createDate(month: 10, day: 12, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 05, second: 0, of: Date())!, quality: 10),
        SleepEntry(date: createDate(month: 10, day: 13, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 10, second: 0, of: Date())!, quality: 10),
        SleepEntry(date: createDate(month: 10, day: 15, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 15, second: 0, of: Date())!, quality: 10),
        /*
        SleepEntry(date: createDate(month: 10, day: 15, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 07, second: 0, of: Date())!, quality: 10),
        */
        
       // SleepEntry(date: createDate(month: 10, day: 16, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 11, second: 0, of: Date())!, quality: 10),
        
        //SleepEntry(date: createDate(month: 10, day: 17, year: 2023)!, bedtime: Calendar.current.date(bySettingHour: 10, minute: 13, second: 0, of: Date())!, quality: 10),
         
        //SleepEntry(date: Date(), bedtime: Calendar.current.date(bySettingHour: 12, minute: 13, second: 0, of: Date())!, quality: 0),

    ]
    
    static var newEntry : SleepEntry{
        SleepEntry(date: Date(), bedtime: Date(), waketime: Date(), quality: 5)
    }
}

extension SleepEntry{
    

}
