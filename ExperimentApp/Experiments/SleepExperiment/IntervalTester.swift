//
//  IntervalTester.swift
//  ExperimentApp
//
//  Created by Bell Chen on 10/20/23.
//

import SwiftUI

struct IntervalTester: View {
    var experiment: SleepExperiment
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("Interval: \(experiment.averageOfInterval(at: 600, for: 15))")
            
        }
    }
}

struct IntervalTester_Previews: PreviewProvider {
    static let sampleExperiment: SleepExperiment = SleepExperiment(goalEntries: 20, dependentVariable: .quality, independentVariable: .bedtime, entries: sampleData, name: "33", notes: "ah")
    static let sampleData: [SleepEntry] =
    [
        SleepEntry(date: Date(), bedtime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!, quality: 5),
        SleepEntry(date: Date(), bedtime: Calendar.current.date(bySettingHour: 9, minute: 45, second: 0, of: Date())!, quality: 6),
        SleepEntry(date: Date(), bedtime: Calendar.current.date(bySettingHour: 9, minute: 35, second: 0, of: Date())!, quality: 7),
        SleepEntry(date: Date(), bedtime: Calendar.current.date(bySettingHour: 9, minute: 40, second: 0, of: Date())!, quality: 6),
        SleepEntry(date: Date(), bedtime: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!, quality: 111),
        
    ]
    
    static var previews: some View {
        IntervalTester(experiment: sampleExperiment)
    }
}
