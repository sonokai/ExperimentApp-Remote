//
//  ExperimentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/28/23.
//

import SwiftUI

struct ExperimentView: View {
    
    
    @Binding var sleepEntries: [SleepEntry]
    @Binding var dayEntries: [DayEntry]
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Active Experiments")){
                    NavigationLink(destination: SleepView2(entries:$sleepEntries)){
                        Text("Sleep Experiment")
                    }
                    NavigationLink(destination:DayView(entries:$dayEntries)){
                        Text("Daily Productivity Experiment")
                    }
                }
                Section(header: Text("Start a new experiment")){
                    
                }
            
            }.navigationTitle("Experiments")
        }.navigationTitle("Experiments")
    }
    
    struct ExperimentView_Previews: PreviewProvider {
        static var previews: some View {
            ExperimentView(sleepEntries: .constant(SleepEntry.sampleData), dayEntries: .constant(DayEntry.sampleData))
        }
    }
}
