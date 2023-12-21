//
//  BedtimePicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct BedtimePicker: View {
    @Binding var experiment: SleepExperiment
    
    @State var bedtime: Date = Calendar.current.startOfDay(for: Date())

    
    var body: some View {
        HStack{
            Image(systemName: "bed.double")
            if let initialValue = experiment.newSleepEntry.bedtime {
                DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
                    .onChange(of: bedtime, perform: { newValue in
                        experiment.newSleepEntry.bedtime = newValue
                    }).onAppear(){
                        bedtime = initialValue
                    }
            } else {
                HStack{
                    Text("Bedtime")
                    Spacer().frame(maxWidth: .infinity)
                    Button(action: {
                        bedtime = Date()
                        experiment.newSleepEntry.bedtime = Date()
                    }, label: {
                        Text("Now")
                    })
                    DatePicker("", selection: $bedtime, displayedComponents: [.hourAndMinute])
                }.onChange(of: bedtime, perform: { newValue in
                    experiment.newSleepEntry.bedtime = newValue
                })
            }
        }
    }
}

struct BedtimePicker_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            BedtimePicker(experiment: .constant(SleepExperiment.bedtimebothExperiment))
        }
    }
}
