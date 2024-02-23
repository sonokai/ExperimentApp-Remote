//
//  SleepEntryDatePicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct SleepEntryDatePicker: View {
    @Binding var experiment: SleepExperiment
    @Binding var timeSelectorPopOver: Bool
    
    var body: some View {
        HStack{
            
            ZStack{
                DatePicker("Entry date", selection: $experiment.newSleepEntry.date, in: experiment.startDate.addingTimeInterval(-5000000)...Date(),displayedComponents: [.date])//.disabled(timeSelectorPopOver)
                //if somoething else is being interacted with, you should not immediately open the datepicker
               /*
                if(timeSelectorPopOver){
                    Color.black.opacity(0.0005)
                }*/
            }
        }
    }
    
    func isInvalidEntry()->Bool{
        for entry in experiment.entries{
            let date = entry.date
            if Calendar.current.isDate(date, equalTo: experiment.newSleepEntry.date, toGranularity: .day) {
                print("Selected day is \(experiment.newSleepEntry.date), but there is an entry with date \(date)")
                return true
            }
        }
        return false
    }
}

struct SleepEntryDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            SleepEntryDatePicker(experiment: .constant(SleepExperiment.bedtimeSampleExperiment), timeSelectorPopOver: .constant(false))
        }
    }
}
