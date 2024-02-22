//
//  MoodEntrySimplifiedView.swift
//  ExperimentApp
//
//  Created by Kai Green on 2/1/24.
//

import SwiftUI

struct MoodEntrySimplifiedView: View {
    
    var tracker: MoodTracker
    @Binding var entry: MoodEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(formattedDate(date:entry.date))")
                .font(.headline)
            Spacer().frame(minHeight: 10)
            HStack {
                Label("\(hourAndMinute(date: entry.time))", systemImage: "clock")
                Spacer()
                Label("\(entry.rating)", systemImage: "star.circle")
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

struct MoodEntrySimplifiedView_Previews: PreviewProvider {
    static var previews: some View {
        MoodEntrySimplifiedView(tracker: MoodTracker.sampleExperiment1, entry: .constant(MoodEntry.newEntry))
    }
}
