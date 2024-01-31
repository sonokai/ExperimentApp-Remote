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
    @Binding var timeSelectorPopOver: Bool
    var body: some View {
        
        DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
            .onChange(of: bedtime, perform: { newValue in
                experiment.newSleepEntry.bedtime = newValue
            }).onAppear(){
                if let initialValue = experiment.newSleepEntry.bedtime {
                    bedtime = initialValue
                }
            }
        
    }
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: bedtime)
    }
}

struct BedtimePicker_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            BedtimePicker(experiment: .constant(SleepExperiment.bedtimebothExperiment), timeSelectorPopOver: .constant(false))
        }
    }
}
