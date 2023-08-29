//
//  ExperimentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/28/23.
//

import SwiftUI

struct ExperimentView: View {
    
    
    @Binding var sleepEntries: [SleepEntry]
    @Binding var dayExperiment: DayExperiment
    @Binding var sleepExperiments: [SleepExperiment]
    @Environment (\.scenePhase) private var scenePhase
    let saveAction : () -> Void
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Active Experiments")){
                    NavigationLink(destination: SleepView2(entries:$sleepEntries)){
                        Text("Sleep Experiment")
                    }
                    NavigationLink(destination:DayView(dayExperiment: $dayExperiment)){
                        Text("Daily Productivity Experiment")
                    }
                }
                Section(header: Text("Start a new experiment")){
                    NavigationLink(destination:SleepIntroView(sleepExperiments: .constant(SleepExperiment.experimentArray), isPresentingSheetView: .constant(true))){
                        Text("Start a sleep experiment")
                    }
                }
                Section(header: Text("Sleep Experiments")){
                    ForEach($sleepExperiments) { $sleepExperiment in
                        NavigationLink(destination: SleepView3(sleepExperiment: $sleepExperiment)) {
                            Text("\(sleepExperiment.name)")
                        }
                    }
                }
                
            }.navigationTitle("Experiments")
        }.navigationTitle("Experiments")
            .onChange(of: scenePhase){ phase in
                if phase == .inactive {saveAction()}
            }
    }
    
    struct ExperimentView_Previews: PreviewProvider {
        static var previews: some View {
            ExperimentView(sleepEntries: .constant(SleepEntry.sampleData), dayExperiment: .constant(DayExperiment.sampleExperiment), sleepExperiments: .constant(SleepExperiment.experimentArray), saveAction: {})
        }
    }
}
