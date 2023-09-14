//
//  DayEntryView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct DayEntryView: View {
    @Binding var entry : DayEntry
    var dependentVariable: DayExperiment.DependentVariable
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(formattedDate(date:entry.date))")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer().frame(maxHeight: 100)
            HStack {
                Label("\(entry.time)", systemImage: "clock")
                Spacer()
                switch(dependentVariable){
                case .focus:
                    Text("Focus: \(entry.focus) ")
                case .plannedToDoneRatio:
                    Text("Ratio: \(entry.plannedToDoneRatio) ")
                case .time:
                    Text("\(entry.minutesWorked) minutes")
                
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
        return dateFormatter.string(from: date)
}

struct DayEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DayEntryView(entry:.constant(DayEntry.newEntry), dependentVariable: .focus)
    }
}

