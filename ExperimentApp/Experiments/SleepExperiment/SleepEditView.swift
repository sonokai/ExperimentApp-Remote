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
    @State private var sliderValue: Double = 5
    // @State private var timeSlept =
    
    @Environment(\.presentationMode) private var presentationMode
    //this line of code allows you to return to the parent class from a child class idk lol chat gpt told me to do it
    
    var body: some View {
        Form {
            DatePicker("Entry date", selection: $tempDate, in: ...Date(),displayedComponents: [.date])
            DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
            DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
            Text("Time slept: \(entry.calculateTimeSlept(sleep: bedtime, wake: waketime))")
            VStack{
                Text("Quality of day")
                HStack{
                    Slider(value: $sliderValue, in: 1...10, step: 0.1).onChange(of: sliderValue) { newValue in
                        quality = Int(newValue)
                    }
                    Text("\(quality)")
                }
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
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
        
    }
    
}
struct SleepEditView_Previews: PreviewProvider {
    static var previews: some View {
        SleepEditView(entry: .constant(SleepEntry.newEntry))
    }
}
