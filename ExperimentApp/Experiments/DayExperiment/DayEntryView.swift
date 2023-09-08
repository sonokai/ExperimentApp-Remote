//
//  DayEntryView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct DayEntryView: View {
    @Binding var entry : DayEntry
    var independentVariable: DayExperiment.IndependentVariable
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(formattedDate(date:entry.date))")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(entry.time)", systemImage: "clock")
                Spacer()
             //   Label("Productivity: \(entry.productivity)", systemImage: "person")
                    
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

struct DayEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DayEntryView(entry:.constant(DayEntry.newEntry), independentVariable: DayExperiment.sampleIndependentVariable)
    }
}

