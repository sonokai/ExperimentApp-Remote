//
//  MoodTrackerHistory.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/29/24.
//

import SwiftUI

struct MoodTrackerDayView: View {
    @Binding var tracker: MoodTracker
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Entries")) {
                    ForEach($tracker.entries.reversed()) { entryBinding in
                        NavigationLink(destination: MoodEntryEditView(entry:entryBinding, tracker: $tracker).navigationTitle("Edit entry")) {
                            Text("Make simplifiedMoodView")
                        }
                    }
                }
            }
        }
    }
}

struct MoodTrackerHistory_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackerDayView(tracker: .constant(MoodTracker.sampleExperiment1))
    }
}
