//
//  MoodSetupView.swift
//  ExperimentApp
//
//  Created by Kai Green on 9/7/23.
//

import SwiftUI

struct MoodSetupView: View {
    
    @Binding var moodExperiments: [MoodExperiment]
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var duration: Int = 0
    @State private var notificationInterval: String = "Every 2 Hours"
    
    let intervals = ["Every Hour", "Every 2 hours", "Every 3 Hours"]
    
    var body: some View {
        NavigationStack{
            Form{
                Text("Let's set up your mood experiment.")
                DatePicker("Start Date", selection: $startDate, in: Date()...,displayedComponents: [.date])
                    .onChange(of: startDate){ _ in
                        updateDuration()
                    }
                DatePicker("End Date", selection: $endDate, in:
                            startDate...,displayedComponents: [.date])
                    .onChange(of: endDate){ _ in
                        updateDuration()
                    }
                HStack {
                    Text("Duration:")
                    Spacer()
                    Text(String(duration))
                    Text("Days")
                }
                
                Picker("Notify", selection: $notificationInterval) {
                    ForEach(intervals, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
    private func updateDuration() -> Void {
        // Calculate the time interval between the two  in seconds
        let date1 = startDate
        let date2 = endDate
        
        let timeInterval = date2.timeIntervalSince(date1)
        
        // Convert the time interval to days and round to the nearest integer
        let days = Int(round(timeInterval / (60 * 60 * 24)))
        
        duration = days
    }
    
    
    struct MoodSetupView_Previews: PreviewProvider {
        static var previews: some View {
            MoodSetupView(moodExperiments: .constant(MoodExperiment.sampleExperiments))
        }
    }
}
