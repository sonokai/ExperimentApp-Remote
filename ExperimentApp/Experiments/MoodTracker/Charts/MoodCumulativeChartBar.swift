//
//  MoodCumulativeChartBar.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/30/24.
//

import Foundation

struct MoodCumulativeChartBar: Identifiable {
    
    let id: UUID
    let timeOfDay: MoodEntry.TimeOfDay
    let avgRating: Double
    
    init(id: UUID = UUID(), entries: [MoodEntry], timeOfDay: MoodEntry.TimeOfDay) {
        self.timeOfDay = timeOfDay
        self.id = id
        
        //we will calculate the average for the given timeofday
        var sum = 0
        var count = 0
        for entry in entries {
            if entry.timeOfDay == timeOfDay {
                count = count + 1
                sum = sum + entry.rating
            }
        }
        if(count == 0){
            self.avgRating = 1
        } else {
            self.avgRating = (Double)(sum)/(Double)(count)
        }
    }
    
}
