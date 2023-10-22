//
//  SimplifiedSleepView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/28/23.
//

import SwiftUI

struct SimplifiedSleepView: View {
    var sleepExperiment: SleepExperiment
    @Binding var entry : SleepEntry
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(formattedDate(date:entry.date))")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                switch(sleepExperiment.independentVariable){
                case .bedtime:
                    Label("Bedtime: \(hourAndMinute(date: entry.bedtime))", systemImage: "clock")
                case .waketime:
                    Label("Wake time: \(hourAndMinute(date: entry.waketime))", systemImage: "clock")
                case .both:
                    Label("Hours of sleep: \(entry.timeSlept)", systemImage: "clock")
                case .hoursSlept:
                    Label("Hours of sleep: \(entry.hoursSlept):\(entry.minutesSlept)", systemImage: "clock")
                }
                
                Spacer()
                
                switch(sleepExperiment.dependentVariable){
                case .productivity:
                    Label("Productivity: \(entry.productivity)", systemImage: "person")
                case .quality:
                    Label("Quality of day: \(entry.quality)", systemImage: "person")
                case .both:
                    Label("Quality of day: \(entry.quality)", systemImage: "person")
                }
                            
            }
            .font(.caption)
        }
        .padding()
    }
}

private func formattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return String(dateFormatter.string(from: date).dropLast(6))
}
/// returns hour and minute string from a Date ex: (3:26)
private func hourAndMinute(date: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    let time = dateFormatter.string(from: date)
    if(time.first == "0") {
        return String(time.dropFirst())  //string is necessary here because dropFirst() returns a substring
    }
    return time
        
}

struct SimplifiedSleepView_Previews: PreviewProvider {
    static var previews: some View {
        SimplifiedSleepView(sleepExperiment: SleepExperiment.bedtimeSampleExperiment, entry:.constant(SleepEntry.newEntry))
    }
}

