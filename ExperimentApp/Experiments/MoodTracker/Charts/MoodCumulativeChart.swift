//
//  MoodChart.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/30/24.
//

import SwiftUI
import Charts
//it takes a list of entries
//makes a chart by averaging the rating at each time of day
//for a specified range (day, week, month, all time)
struct MoodCumulativeChart: View {
    
    @State var barCharEntries: [MoodCumulativeChartBar] = []
    var entries: [MoodEntry]
    var body: some View {
        
        VStack {
            Text("Average Mood in....").font(.headline).fontWeight(.bold)
            Chart(barCharEntries){entry in
                BarMark(
                    x: .value("Time of day", entry.timeOfDay.rawValue),
                    y: .value("rating", entry.avgRating))
            }.onAppear(){
                for timeOfDay in MoodEntry.TimeOfDay.allCases {
                    let newEntry = MoodCumulativeChartBar(entries: entries, timeOfDay: timeOfDay)
                    print("Time of day: \(timeOfDay.rawValue), average: \(newEntry.avgRating)" )
                    barCharEntries.append(newEntry)
                }
            }
        }
        
    }
   
    //function which takes in a timeOfDay looks through the array of entries at that timeOfDay and averages it, returns average
    
    
    
}

#Preview {
    MoodCumulativeChart(entries: MoodEntry.sampleData).frame(height: 300)
}
