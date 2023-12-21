//
//  NewSleepEntryView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/20/23.
//

import SwiftUI
//make it so that it needs interaction before you get a value
//interaction with all makes done avaiable
struct NewSleepEntryView: View {
    
    @Binding var experiment: SleepExperiment
    @State private var selectedDate = Date()
    @State var timeSelectorPopOver = false
    
    var body: some View {
        
            SleepEntryDatePicker(experiment: $experiment, timeSelectorPopOver: timeSelectorPopOver)
            
          //  Divider()
            
            switch(experiment.independentVariable){
            case .bedtime:
                BedtimePicker(experiment: $experiment)
            case .waketime:
                WaketimePicker(experiment: $experiment)
            case .both:
                BedtimePicker(experiment: $experiment)
                WaketimePicker(experiment: $experiment)
            case .hoursSlept:
                TimeSleptPicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
            }//end of switch
        
            switch(experiment.dependentVariable){
            case .quality:
                SleepDependentVarPicker(label: "Quality of day", optional: $experiment.newSleepEntry.quality)
            case .productivity:
                SleepDependentVarPicker(label: "Productivity", optional: $experiment.newSleepEntry.productivity, image: "gearshape")
            case .both:
                SleepDependentVarPicker(label: "Quality of day", optional: $experiment.newSleepEntry.quality)
                SleepDependentVarPicker(label: "Productivity", optional: $experiment.newSleepEntry.productivity, image: "gearshape")
            }
        Button("Done"){
            experiment.initiateSleepEntry()
        }.disabled(!experiment.newSleepEntry.isReady(experiment: experiment))
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

    



struct NewSleepEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Form{
                NewSleepEntryView(experiment: .constant(SleepExperiment.hoursSleptSampleExperiment))
            }.buttonStyle(.borderless)
        }
    }
}
