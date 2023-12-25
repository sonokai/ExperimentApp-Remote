//
//  SleepEditView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/26/23.
//

import SwiftUI

struct SleepEditView: View {
    @Binding var entry: SleepEntry
    
    @State private var selectedDate = Date()
    @State private var bedtime = Date()
    @State private var waketime = Date()
    @State private var timeSlept = "0"
    @State private var quality: Int = 5
    @State private var productivity: Int = 5
    @State private var hoursSlept: Int = 0
    @State private var minutesSlept: Int = 0
    
    
    @Binding var experiment: SleepExperiment
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Form {
            
            
                DatePicker("Entry date", selection: $selectedDate, in: ...Date(),displayedComponents: [.date])

            switch(experiment.independentVariable){
            case .bedtime:
                
                DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
            case .waketime:
                DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
            case .both:
                DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
                DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
                Text("Time slept: \(SleepEntry.calculateTimeSlept(sleep: bedtime, wake: waketime))")
            case .hoursSlept:
                
                TimeSelector(hours: $hoursSlept, minutes: $minutesSlept)
                
            }
            
            switch(experiment.dependentVariable){
            case .quality:
                SleepPicker(label: "Quality of day", value: $quality)
            case .productivity:
                SleepPicker(label: "Productivity", value: $productivity)
            case .both:
                SleepPicker(label: "Quality of day", value: $quality)
                SleepPicker(label: "Productivity", value: $productivity)
            }
        
            
        }.toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    //update the entry binding when and if the done button is pressed
                    entry.date = selectedDate
                    entry.bedtime = bedtime
                    entry.waketime = waketime
                    entry.timeSlept = timeSlept
                    entry.quality = quality
                    entry.productivity = productivity
                    entry.hoursSlept = hoursSlept
                    entry.minutesSlept = minutesSlept
                    experiment.sortEntriesByDate()
                    presentationMode.wrappedValue.dismiss()
                }.disabled(isInvalidEntry())
            }
        }
        
        
    }
    func isInvalidEntry()->Bool{
        for entry in experiment.entries{
            let date = entry.date
            if Calendar.current.isDate(date, equalTo: selectedDate, toGranularity: .day) {
                print("Selected day is \(selectedDate), but there is an entry with date \(date)")
                return true
            }
        }
        return false
    }
    
}
struct SleepEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            
            SleepEditView(entry: .constant(SleepEntry.newEntry),experiment: .constant(SleepExperiment.hoursSleptSampleExperiment))
            
        }
    }
}
