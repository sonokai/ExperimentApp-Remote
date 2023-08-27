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
    var time: Time
    //enum for time of day (morning afternoon evening) independent variable
    var productivity: Int //dependent variable
    
    init(id: UUID = UUID(), date: Date, time: Time, productivity: Int) {
        self.id = id
        self.date = date
        self.time = time
        self.productivity = productivity
    }
    
}
extension DayEntry{
    static let sampleData: [DayEntry] =
    [
        DayEntry(date: Date(), time: .morning, productivity: 5),
        DayEntry(date: Date(), time: .afternoon, productivity: 8),
        DayEntry(date: Date(), time: .evening, productivity: 7)
    ]
    
    static var newEntry : DayEntry{
        DayEntry(date: Date(), time: .morning, productivity: 5)
    }
}

