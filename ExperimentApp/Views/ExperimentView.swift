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
    @Binding var sleepExperiments: [SleepExperiment]
    
    
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
                    NavigationLink(destination:SleepIntroView()){
                        Text("Start a sleep experiment")
                    }
                }
                Section(header: Text("Sleep Experiments")){
                    ForEach($sleepExperiments) { sleepExperiment in
                        NavigationLink(destination: SleepView3(sleepExperiment: sleepExperiment)
                            .navigationTitle("Edit entry")) {
                        }
                    }
                }
            
            }.navigationTitle("Experiments")
        }.navigationTitle("Experiments")
    }
    
    struct ExperimentView_Previews: PreviewProvider {
        static var previews: some View {
            ExperimentView(sleepEntries: .constant(SleepEntry.sampleData), dayEntries: .constant(DayEntry.sampleData), sleepExperiments: .constant(SleepExperiment.experimentArray))
        }
    }
}
