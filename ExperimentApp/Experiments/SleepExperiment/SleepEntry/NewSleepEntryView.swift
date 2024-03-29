//
//  NewSleepEntryView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/20/23.
//

import SwiftUI
struct NewSleepEntryView: View {
    
    @Binding var experiment: SleepExperiment
    
    @State var timeSelectorPopOver = false
    @State var sheet = false
    @Environment(\.presentationMode) private var presentationMode
    @State var replaceAlert: Bool = false
    var body: some View {
        
        HStack{
            Text("Add a new entry")
            Spacer().frame(maxWidth: .infinity)
            Button(action: {
                sheet.toggle()
            }, label: {
                Image(systemName: "info.circle")
            }).sheet(isPresented: $sheet, content: {
                SleepProcedureView(experiment: experiment, sheet: $sheet)
            })
        }
        
        SleepEntryDatePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
        
        switch(experiment.independentVariable){
        case .bedtime:
            BedtimePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
        case .waketime:
            WaketimePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
        case .both:
            BedtimePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver).onChange(of: experiment.newSleepEntry.bedtime, perform: { _ in
                
                if let bedtime = experiment.newSleepEntry.bedtime, let waketime = experiment.newSleepEntry.waketime{
                    let (hour, minute) = SleepEntry.returnTimeSlept(sleep: bedtime, wake: waketime)
                    experiment.newSleepEntry.hoursSlept = hour
                    experiment.newSleepEntry.minutesSlept = minute
                    print("Updated hour and minute: new hour \(hour), new minute: \(minute)" )
                }
                
            })
            WaketimePicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver).onChange(of: experiment.newSleepEntry.waketime, perform: { _ in
                if let bedtime = experiment.newSleepEntry.bedtime, let waketime = experiment.newSleepEntry.waketime{
                    let (hour, minute) = SleepEntry.returnTimeSlept(sleep: bedtime, wake: waketime)
                    experiment.newSleepEntry.hoursSlept = hour
                    experiment.newSleepEntry.minutesSlept = minute
                    print("Updated hour and minute: new hour \(hour), new minute: \(minute)" )
                }
            })
        case .hoursSlept:
            TimeSleptPicker(experiment: $experiment, timeSelectorPopOver: $timeSelectorPopOver)
        }
        
        switch(experiment.dependentVariable){
        case .quality:
            SleepDependentVarPicker(label: "Quality of day", optional: $experiment.newSleepEntry.quality, timeSelectorPopOver: $timeSelectorPopOver)
        case .productivity:
            SleepDependentVarPicker(label: "Productivity", optional: $experiment.newSleepEntry.productivity,image: "gearshape", timeSelectorPopOver: $timeSelectorPopOver)
        case .both:
            SleepDependentVarPicker(label: "Quality of day", optional: $experiment.newSleepEntry.quality, timeSelectorPopOver: $timeSelectorPopOver)
            SleepDependentVarPicker(label: "Productivity", optional: $experiment.newSleepEntry.productivity,image: "gearshape", timeSelectorPopOver: $timeSelectorPopOver)
        }
        
        Button("Done"){
            if(isInvalidEntry()){
                replaceAlert = true
            } else {
                experiment.initiateSleepEntry()
                presentationMode.wrappedValue.dismiss()
            }
        }.alert("There is another entry with the date \(formatToMonthAndDay()). Replace this entry?", isPresented: $replaceAlert, actions: {
            Button("Continue", role: .destructive){
                experiment.entries.removeAll{ entry in  Calendar.current.isDate(entry.date, equalTo: experiment.newSleepEntry.date, toGranularity: .day)
                }
                
                experiment.initiateSleepEntry()
                
                presentationMode.wrappedValue.dismiss()
            }
        }).disabled(!experiment.newSleepEntry.isReady(experiment: experiment))
        
        
    }
    func formatToMonthAndDay() -> String {
        let date = experiment.newSleepEntry.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        let formattedDateString = dateFormatter.string(from: date)
        return formattedDateString
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
                NewSleepEntryView(experiment: .constant(SleepExperiment.bothTimesSampleExperiment))
            }.buttonStyle(.borderless)
        }
    }
}
