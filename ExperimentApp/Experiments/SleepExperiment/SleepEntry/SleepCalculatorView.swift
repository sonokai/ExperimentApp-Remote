//
//  SleepCalculatorView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct SleepCalculatorView: View {
    @Binding var experiment: SleepExperiment
    @State var bedtime: Date = Calendar.current.startOfDay(for: Date())
    @State var waketime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        Form{
            DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
            DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
            HStack{
                Text("Time slept: ")
                Spacer()
                Text(SleepEntry.calculateTimeSlept(sleep: bedtime, wake: waketime))
            }
            Button("Log time in new entry"){
                let (hours, minutes) = SleepEntry.returnTimeSlept(sleep: bedtime, wake: waketime)
                experiment.newSleepEntry.hoursSlept = hours
                experiment.newSleepEntry.minutesSlept = minutes
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}

struct SleepCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        SleepCalculatorView(experiment: .constant(SleepExperiment.hoursSleptSampleExperiment))
    }
}
