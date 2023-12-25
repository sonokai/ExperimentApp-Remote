//
//  ExperimentView2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/27/23.
//

import SwiftUI

struct ExperimentView: View {
    @Environment (\.scenePhase) private var scenePhase
    @Binding var appData: AppData
    let saveAction : () -> Void
    
    @State var showSleepExperiment: Bool = true
    var body: some View {
        NavigationStack{
            Form{
                
                ForEach($appData.sleepExperiments) { $sleepExperiment in
                    Section(header: SleepExperimentHeader(title: sleepExperiment.name, isOn: $showSleepExperiment)){
                        if(showSleepExperiment){
                            NewSleepEntryView(experiment: $sleepExperiment)
                        } else {
                            NavigationLink(destination: SleepView(experiment: $sleepExperiment)){
                                Text("Main page")
                            }
                        }
                    }
                }
                
                ForEach($appData.dayExperiments) { $dayExperiment in
                    NavigationLink(destination: DayView(experiment: $dayExperiment)){
                        Text("\(dayExperiment.name)")
                    }
                }
                ForEach($appData.moodExperiments){ $moodExperiment in
                    NavigationLink(destination: Text("Put mood experiment main view here")){
                        Text(moodExperiment.name)
                    }
                }
            }.buttonStyle(.borderless)
            .navigationTitle("My Experiments")
        }
        .navigationTitle("Experiments")
        .onChange(of: scenePhase){ phase in
            if phase == .inactive {saveAction()}
        }

    }
}

struct ExperimentView2_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView(appData: .constant(AppData.sampleData), saveAction: {})
    }
}
