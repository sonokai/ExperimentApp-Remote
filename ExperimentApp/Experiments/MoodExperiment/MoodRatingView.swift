//
//  MoodRatingView.swift
//  ExperimentApp
//
//  Created by Kai Green on 9/8/23.
//

import SwiftUI

struct MoodRatingView: View {
    @Binding var moodEntries: [MoodEntry]
    @State private var selectedRating = 5

    var body: some View {
        VStack {
            Text("Rate Your Mood:")
            Picker("Mood", selection: $selectedRating) {
                ForEach(1...10, id: \.self) { rating in
                    Text("\(rating)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("Submit") {
                let newMoodEntry = MoodEntry(date: Date(), rating: selectedRating)
                moodEntries.append(newMoodEntry)
                
            }
        }
    }
}

struct MoodRatingView_Previews: PreviewProvider {
    static var previews: some View {
        MoodRatingView(moodEntries:.constant(MoodEntry.sampleData))
    }
}
