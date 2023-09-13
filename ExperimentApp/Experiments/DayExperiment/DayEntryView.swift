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
             //   Label("Productivity: \(entry.productivity)", systemImage: "person")
                switch(dependentVariable){
                case .focus:
                    Text("Focus:")
                case .plannedToDoneRatio:
                    Text("ratio picker")
                case .time:
                    Text("time")
                
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

