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
            Spacer().frame(minHeight: 10)
            HStack {
                switch(sleepExperiment.independentVariable){
                case .bedtime:
                    Label("\(hourAndMinute(date: entry.bedtime))", systemImage: "clock")
                case .waketime:
                    Label("\(hourAndMinute(date: entry.waketime))", systemImage: "clock")
                case .both:
                    Label(timeString(entry: entry), systemImage: "clock")
                case .hoursSlept:
                    Label(timeString(entry: entry), systemImage: "clock")
                }
                
                Spacer()
                
                switch(sleepExperiment.dependentVariable){
                case .productivity:
                    Label("\(entry.productivity)", systemImage: "gearshape.2.fill")
                case .quality:
                    Label("\(entry.quality)", systemImage: "sun.max")
                case .both:
                    Label("\(entry.quality)", systemImage: "sun.max")
                }
                            
            }
            .font(.caption)
        }
        .padding()
    }
}
func timeString(entry: SleepEntry)-> String{
    if(entry.minutesSlept<10){
        return "\(entry.hoursSlept):0\(entry.minutesSlept)"
    }
    return "\(entry.hoursSlept):\(entry.minutesSlept)"
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
        VStack{
            SimplifiedSleepView(sleepExperiment: SleepExperiment.bedtimeSampleExperiment, entry:.constant(SleepEntry.newEntry))
        
        }
    }
}

