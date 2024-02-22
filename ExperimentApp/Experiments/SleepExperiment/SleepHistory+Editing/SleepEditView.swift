//
//  SleepEditView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/26/23.
//

import SwiftUI

struct SleepEditView: View {
    @Binding var entry: SleepEntry
    
    @Binding var experiment: SleepExperiment
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Form {
            
            
            DatePicker("Entry date", selection: $entry.date,  in: experiment.startDate.addingTimeInterval(-5000000)...Date(),displayedComponents: [.date])

            switch(experiment.independentVariable){
            case .bedtime:
                
                DatePicker("Bedtime", selection: $entry.bedtime, displayedComponents: [.hourAndMinute])
            case .waketime:
                DatePicker("Wake time", selection: $entry.waketime, displayedComponents: [.hourAndMinute])
            case .both:
                DatePicker("Bedtime", selection: $entry.bedtime, displayedComponents: [.hourAndMinute])
                DatePicker("Wake time", selection: $entry.waketime, displayedComponents: [.hourAndMinute])
                Text("Time slept: \(SleepEntry.calculateTimeSlept(sleep: entry.bedtime, wake: entry.waketime))")
            case .hoursSlept:
                
                TimeSelector(hours: $entry.hoursSlept, minutes: $entry.minutesSlept)
                
            }
            
            switch(experiment.dependentVariable){
            case .quality:
                SleepPicker(label: "Quality of day", value: $entry.quality)
            case .productivity:
                SleepPicker(label: "Productivity", value: $entry.productivity)
            case .both:
                SleepPicker(label: "Quality of day", value: $entry.quality)
                SleepPicker(label: "Productivity", value: $entry.productivity)
            }
        
            
        }.toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    let (hour, minute) = SleepEntry.returnTimeSlept(sleep: entry.bedtime, wake: entry.waketime)
                    entry.hoursSlept = hour
                    entry.minutesSlept = minute
                    experiment.sortEntriesByDate()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    
    
}
struct SleepEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            
            SleepEditView(entry: .constant(SleepEntry.newEntry),experiment: .constant(SleepExperiment.hoursSleptSampleExperiment))
            
        }
    }
}
