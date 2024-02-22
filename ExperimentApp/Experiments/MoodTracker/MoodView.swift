//
//  MoodView.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/19/24.
//

import SwiftUI

struct MoodView: View {
  
    @Binding var tracker: MoodTracker
    @State private var isShowingMoodRatingView = false
    
    var body: some View {
        NavigationStack {
            Form {
                /*Button(action: {
                    isShowingMoodRatingView = true
                },label: {
                    Text("Make An Entry").font(.headline)
                })
                .navigationDestination(isPresented: $isShowingMoodRatingView) {
                    // Destination view when navigation is triggered
                    MoodRatingView(moodEntries: $moodEntries, moodExperiments: $moodExperiments, appData: $appData)
                }*/
                
                MoodCumulativeChart(entries: tracker.entries)
        
            }
        }
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView(tracker: .constant(MoodTracker.sampleExperiment1))
    }
}
