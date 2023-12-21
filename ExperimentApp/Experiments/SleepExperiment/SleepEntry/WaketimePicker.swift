//
//  BedtimePicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct WaketimePicker: View {
    @Binding var experiment: SleepExperiment
    
    @State var waketime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()

    
    var body: some View {
        HStack{
            Image(systemName: "bed.double")
            if let initialValue = experiment.newSleepEntry.bedtime {
                DatePicker("Waketime", selection: $waketime, displayedComponents: [.hourAndMinute])
                    .onChange(of: waketime, perform: { newValue in
                        experiment.newSleepEntry.waketime = newValue
                    })
                    .onAppear(){
                        waketime = initialValue
                    }
            } else {
                HStack{
                    Text("Waketime")
                    Spacer().frame(maxWidth: .infinity)
                    Button(action: {
                        waketime = Date()
                        experiment.newSleepEntry.waketime = Date()
                    }, label: {
                        Text("Now")
                    })
                    DatePicker("", selection: $waketime, displayedComponents: [.hourAndMinute])
                }.onChange(of: waketime, perform: { newValue in
                    experiment.newSleepEntry.waketime = newValue
                })
            }
        }
    }
}

struct WaketimePicker_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            WaketimePicker(experiment: .constant(SleepExperiment.bedtimebothExperiment))
        }
    }
}
