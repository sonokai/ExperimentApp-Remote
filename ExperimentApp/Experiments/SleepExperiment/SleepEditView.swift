//
//  SleepEditView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/26/23.
//

import SwiftUI

struct SleepEditView: View {
    @Binding var entry: SleepEntry
    
    @State private var tempDate = Date()
    @State private var bedtime = Date()
    @State private var waketime = Date()
    @State private var timeSlept = "0"
    @State private var quality: Int = 5
    @State private var productivity: Int = 5
    @State private var hoursSlept: Int = 0
    @State private var minutesSlept: Int = 0
    
    var sleepExperiment: SleepExperiment
    
    @Environment(\.presentationMode) private var presentationMode
    //this line of code allows you to return to the parent class from a child class idk lol chat gpt told me to do it
    
    var body: some View {
        Form {
            DatePicker("Entry date", selection: $tempDate, in: ...Date(),displayedComponents: [.date])
            
            switch(sleepExperiment.independentVariable){
            case .bedtime:
                DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
            case .waketime:
                DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
            case .both:
                DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
                DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
                Text("Time slept: \(entry.calculateTimeSlept(sleep: bedtime, wake: waketime))")
            case .hoursSlept:
                TimeSelector(hours: $hoursSlept, minutes: $minutesSlept)
            }
            
            switch(sleepExperiment.dependentVariable){
            case .quality:
                SliderView(name: "Quality of day", value: $quality)
            case .productivity:
                SliderView(name: "Productivity", value: $productivity)
            case .both:
                SliderView(name: "Quality of day", value: $quality)
                SliderView(name: "Productivity", value: $productivity)
            }
        
            
        }.toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    //update the entry binding when and if the done button is pressed
                    entry.date = tempDate
                    entry.bedtime = bedtime
                    entry.waketime = waketime
                    entry.timeSlept = timeSlept
                    entry.quality = quality
                    entry.productivity = productivity
                    entry.hoursSlept = hoursSlept
                    entry.minutesSlept = minutesSlept
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
        
    }
    
}
struct SleepEditView_Previews: PreviewProvider {
    static var previews: some View {
        SleepEditView(entry: .constant(SleepEntry.newEntry),sleepExperiment: SleepExperiment.hoursSleptSampleExperiment)
    }
}
