//
//  MoodEntryEditView.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/29/24.
//

import SwiftUI

struct MoodEntryEditView: View {
    @Binding var entry: MoodEntry
    
    @State private var selectedRating = 5
    @State private var selectedDay = Date()
    @State private var selectedTime = Date()
    @State private var showErrorAlert = false
    @State private var isShowingMoodView = false
    @State private var insights = ""
   
    
    
    @Binding var tracker: MoodTracker
    
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
      
            Form {
                Section(header: Text("Entries")) {
                    VStack {
                        Picker("Mood", selection: $selectedRating) {
                            ForEach(1...10, id: \.self) { rating in
                                Text("\(rating)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        DatePicker("Update Day:", selection: $selectedDay, displayedComponents: [.date])
                        HStack {
                            DatePicker("Update Time:", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            Button(action: {
                                self.selectedTime = Date()
                            },label: {
                                Text("Now")
                            }).padding()
                        }
                    }
                }
                    
                        
                Section(header: InsightsHeader()) {
                    HStack{
                        TextField(" New Insights (Optional)", text: $insights)
                        
                    }
                        }
                    
                }

            .onAppear {
                setupInitialState()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        entry.rating = selectedRating
                        entry.date = selectedDay
                        entry.time = selectedTime
                        entry.insights = insights
                        
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
            

    }
    private func setupInitialState() {
            selectedRating = entry.rating
            selectedDay = entry.date
            selectedTime = entry.time
            insights = entry.insights
    }
}

struct InsightsHeader: View{
    @State var sheet = false
    
    var body: some View{
        HStack{
            Text("Insights").font(.caption)
            Spacer()
            Button(action: {
                sheet.toggle()
            }, label: {
                Image(systemName: "info.circle")
            }).sheet(isPresented: $sheet, content: {
                NotesExplanationView(sheet: $sheet)
            })
        }
    }
}

struct MoodEntryEditView_Previews: PreviewProvider {
    static var previews: some View {
        MoodEntryEditView(entry: .constant(MoodEntry.newEntry), tracker: .constant(MoodTracker.sampleExperiment1))
    }
}
