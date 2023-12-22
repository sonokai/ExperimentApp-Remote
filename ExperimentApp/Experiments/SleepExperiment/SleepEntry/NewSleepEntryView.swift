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
    @State var sheet = false
    var body: some View {
        NavigationLink(destination: SleepView(experiment: $experiment)){
            ProgressView(value: Double(experiment.entries.count)/Double(experiment.goalEntries)) {
                Text("Goal: \(experiment.goalEntries) entries")
                if(experiment.entries.count < experiment.goalEntries){
                    Text("Progress: \(Int(Double(experiment.entries.count)/Double(experiment.goalEntries)*100))%")
                }else {
                    Text("View your results")
                }
                
            }
        }
        
        HStack{
            Text("Add a new entry").bold()
            Spacer().frame(maxWidth: .infinity)
            Button(action: {
                sheet.toggle()
            }, label: {
                Image(systemName: "info.circle")
            }).sheet(isPresented: $sheet, content: {
                SleepProcedureView(experiment: experiment, sheet: $sheet)
            })
        }
        
        SleepEntryDatePicker(experiment: $experiment, timeSelectorPopOver: timeSelectorPopOver)
        
        switch(experiment.independentVariable){
        case .bedtime:
            BedtimePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
        case .waketime:
            WaketimePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
        case .both:
            BedtimePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
            WaketimePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
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
                NewSleepEntryView(experiment: .constant(SleepExperiment.waketimeSampleExperiment))
            }.buttonStyle(.borderless)
        }
    }
}
