//
//  SimplifiedSleepView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/28/23.
//

import SwiftUI

struct SimplifiedSleepView: View {
    @Binding var entry : SleepEntry
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(formattedDate(date:entry.date))")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("Hours of sleep: \(entry.timeSlept)", systemImage: "clock")
                Spacer()
                Label("Quality of day: \(entry.quality)", systemImage: "person")
                    
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
        return dateFormatter.string(from: date)
}

struct SimplifiedSleepView_Previews: PreviewProvider {
    static var previews: some View {
        SimplifiedSleepView(entry:.constant(SleepEntry.newEntry))
    }
}

