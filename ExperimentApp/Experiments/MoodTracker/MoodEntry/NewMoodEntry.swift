//
//  NewMoodEntry.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/29/24.
//

import Foundation

struct NewMoodEntry: Identifiable, Codable {
    let id: UUID
    let rating: Int
    var date: Date
    var time: Date
    var insights: String
    
    init(id: UUID = UUID(), rating: Int, date: Date,  time: Date, insights: String) {
        self.id = id
        self.rating = rating
        self.date = date
        self.time = time
        self.insights = insights
    }
}
