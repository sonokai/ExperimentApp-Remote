//
//  MoodRatingView.swift
//  ExperimentApp
//
//  Created by Kai Green on 9/8/23.
//
//add toolbar button so view closes when you type submit and navigates back to MoodView
//add navigation title that says "New Entry" or something like that.

import SwiftUI

struct MoodRatingView: View {
    @Binding var moodEntries: [MoodEntry]
    @Binding var moodExperiments: [MoodTracker]
    @Binding var appData: AppData
    @State private var selectedRating = 5
    @State private var selectedDay = Date()
    @State private var selectedTime = Date()
    @State private var showErrorAlert = false
    @State private var isShowingMoodView = false
    @State private var insights = ""
    
    @State var sheet = false
    

    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    Text("Rate Your Mood:")
                    Picker("Mood", selection: $selectedRating) {
                        ForEach(1...10, id: \.self) { rating in
                            Text("\(rating)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    DatePicker("Select Day:", selection: $selectedDay, displayedComponents: [.date])
                    HStack {
                        DatePicker("Select Time:", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        Button(action: {
                            self.selectedTime = Date()
                        },label: {
                            Text("Now")
                        }).padding()
                    }
                    HStack{
                        TextField("Insights (Optional)", text: $insights)
                        Spacer().frame(maxWidth: .infinity)
                        Button(action: {
                            sheet.toggle()
                        }, label: {
                            Image(systemName: "info.circle")
                        }).sheet(isPresented: $sheet, content: {
                            NotesExplanationView(sheet: $sheet)
                        })
                    }
                    Button("Submit") {
                        if selectedRating == 0 {
                            showErrorAlert = true
                        } else {
                            let newMoodEntry = MoodEntry(rating: selectedRating, date: selectedDay, time: selectedTime, insights: insights)
                            moodEntries.append(newMoodEntry)
                            isShowingMoodView = true
                        }
                    }
                    .navigationDestination(isPresented: $isShowingMoodView) {
                        MoodView(moodEntries: $moodEntries, moodExperiments: $moodExperiments, appData: $appData)
                    }
                    .alert(isPresented: $showErrorAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Please make sure all fields are filled correctly."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
        }
    }
}

struct MoodRatingView_Previews: PreviewProvider {
    static var previews: some View {
        MoodRatingView(moodEntries:.constant(MoodEntry.sampleData),  moodExperiments: .constant(MoodTracker.sampleExperiments), appData: .constant(AppData.sampleData))
    }
}
