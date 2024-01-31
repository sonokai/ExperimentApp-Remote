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
    @Binding var timeSelectorPopOver: Bool
    @State var interacted: Bool = false
    var body: some View {
        
        DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
            .onChange(of: waketime, perform: { newValue in
                experiment.newSleepEntry.waketime = newValue
            }).onAppear(){
                if let initialValue = experiment.newSleepEntry.waketime {
                    waketime = initialValue
                }
            }
        
    }
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: waketime)
    }
}

struct WaketimePicker_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            WaketimePicker(experiment: .constant(SleepExperiment.waketimeSampleExperiment), timeSelectorPopOver: .constant(false))
        }
    }
}
