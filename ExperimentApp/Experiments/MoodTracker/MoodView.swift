//
//  MoodView.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/19/24.
//

import SwiftUI

struct MoodView: View {
    @StateObject var viewModel = MoodTrackerViewModel()
    @Binding var moodEntries: [MoodEntry]
    @Binding var moodExperiments: [MoodTracker]
    @Binding var appData: AppData
    @State private var isShowingMoodRatingView = false
    
    var body: some View {
        NavigationStack {
            Form {
                Button(action: {
                    isShowingMoodRatingView = true
                },label: {
                    Text("Make An Entry").font(.headline)
                })
                .navigationDestination(isPresented: $isShowingMoodRatingView) {
                    // Destination view when navigation is triggered
                    MoodRatingView(moodEntries: $moodEntries, moodExperiments: $moodExperiments, appData: $appData)
                }
                
        
            }
        }
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView(moodEntries: .constant(MoodEntry.sampleData), moodExperiments: .constant(MoodTracker.sampleExperiments), appData: .constant(AppData.sampleData))
    }
}
