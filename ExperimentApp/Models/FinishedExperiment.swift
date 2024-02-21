//
//  FinishedExperiment.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/26/23.
//

import Foundation

struct FinishedExperiment: Identifiable, Codable{
    let id: UUID
    let name: String
    let startDate: Date
    let endDate: Date
    let insights: [Insight]
    let medal: Medal
    
    enum Medal: String, Codable{
        case none
        case bronze
        case silver
        case gold
    }
    
    init(id: UUID = UUID(), name: String, startDate: Date, endDate: Date, insights: [Insight], medal: Medal){
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.insights = insights
        self.medal = medal
    }
    static func createDate(month: Int, day: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
    static let sample = FinishedExperiment(name: "Sleep Experiment", startDate: createDate(month: 10, day: 1, year: 2023)!, endDate: createDate(month: 12, day: 1, year: 2023)!, insights: sampleArrayOfInsights, medal: .bronze)
    static let sampleArray: [FinishedExperiment] = [
        FinishedExperiment(name: "Sleep Experiment 1", startDate: createDate(month: 10, day: 1, year: 2023)!, endDate: createDate(month: 12, day: 1, year: 2023)!, insights: sampleArrayOfInsights, medal: .silver),
      
    ]
    static let sampleArrayOfInsights = [
        Insight(text:"When I sleep between 9:00 PM and 10:00 PM, I have the best quality of day.", date: Date()),
        Insight(text:"When I wake up between 6:00 AM and 7:00 AM, I have the best productivity.",date: Date()),
        Insight(text: "Sleeping between 8-9 hours is best for me.",date:Date()),
        Insight(text: "Productivity drops by 20% when I sleep less than 6 hours",date: Date())
    ]
}
