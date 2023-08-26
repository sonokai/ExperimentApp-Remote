//
//  SleepEntry.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/28/23.
//

import Foundation

struct SleepEntry: Identifiable {
    let id: UUID
    var date: Date
    var bedtime: Date
    var waketime: Date
    var quality: Int
    var timeSlept: String
    init(id: UUID = UUID(), date: Date, bedtime: Date, waketime: Date, quality: Int) {
        self.id = id
        self.date = date
        self.bedtime = bedtime
        self.waketime = waketime
        self.quality = quality
        self.timeSlept = "0"
    }
    //mutating allows it to modify self? idk
    mutating func updateTimeSlept(){
        timeSlept = calculateTimeSlept(sleep: bedtime, wake: waketime)
    }
    func calculateTimeSlept(sleep: Date, wake: Date) -> (String){
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
        return "\(hourDifference) hours \(minuteDifference) minutes"
    }
    func getHour(date: Date) -> (Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        guard let hour = components.hour else {
            fatalError("Failed to extract")
        }
        return hour
    }
    func getMinute(date: Date) -> (Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date)
        guard let minute = components.minute else {
            fatalError("Failed to extract")
        }
        return minute
    }
    func hasSameAMPM(date1: Date, date2: Date)-> (Bool){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: date1) == dateFormatter.string(from: date2)
    }
}


extension SleepEntry {
    
    static let sampleData: [SleepEntry] =
    [
        newEntry, newEntry, newEntry
    ]
    
    static var newEntry : SleepEntry{
        SleepEntry(date: Date(), bedtime: Date(), waketime: Date(), quality: 5)
    }
}

extension SleepEntry{
    

}