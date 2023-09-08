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
    var plannedToDoneRatio: Double?
    var focus: Int?
    var worktime: Int?
    
    
    
    init(id: UUID = UUID(), date: Date, time: String) {
        self.id = id
        self.date = date
        self.time = time
        
    }
    
}
extension DayEntry{
    static let sampleData: [DayEntry] =
    [
        DayEntry(date: Date(), time: "Morning"),
        DayEntry(date: Date(), time: "Afternoon"),
        DayEntry(date: Date(), time: "Evening")
    ]
    
    static var newEntry : DayEntry{
        DayEntry(date: Date(), time: "Ah")
    }
}

