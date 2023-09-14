//
//  DayEntry.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import Foundation

struct DayEntry: Identifiable, Codable{
    let id: UUID
    var date: Date
    var time: String
    var plannedToDoneRatio: Double
    var focus: Int
    var minutesWorked: Int
    
    
    
    init(id: UUID = UUID(), date: Date, time: String, plannedToDoneRatio: Double = 1, focus: Int = 5, minutesWorked: Int = 2) {
        self.id = id
        self.date = date
        self.time = time
        self.plannedToDoneRatio = plannedToDoneRatio
        self.focus = focus
        self.minutesWorked = minutesWorked
        
    }
    
}
extension DayEntry{
    static let sampleData: [DayEntry] =
    [
        DayEntry(date: Date(), time: "Morning", focus: 5),
        DayEntry(date: Date(), time: "Afternoon", focus: 6),
        DayEntry(date: Date(), time: "Evening", focus: 7),
        DayEntry(date: Date(), time: "Evening", focus: 8),
        DayEntry(date: Date(), time: "Evening", focus: 9),
        DayEntry(date: Date(), time: "Evening", focus: 10),
        DayEntry(date: Date(), time: "Before dinner", focus: 10),
        DayEntry(date: Date(), time: "After school", focus: 3)
        
    ]
    
    static var newEntry : DayEntry{
        DayEntry(date: Date(), time: "Ah")
    }
}

