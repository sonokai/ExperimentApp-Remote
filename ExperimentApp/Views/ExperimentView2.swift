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
    @State var isPresentingSheetView = false
    let saveAction : () -> Void
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Active Experiments")){
                    ForEach($appData.sleepExperiments) { $sleepExperiment in
                        NavigationLink(destination: SleepView(sleepExperiment: $sleepExperiment)){
                            Text("\(sleepExperiment.name)")
                        }
                    }
                    ForEach($appData.dayExperiments) { $dayExperiment in
                        NavigationLink(destination:DayView(dayExperiment: $dayExperiment)){
                            Text("\(dayExperiment.name)")
                        }
                    }
                    ForEach($appData.moodExperiments){ $moodExperiment in
                        NavigationLink(destination: Text("Put mood experiment main view here")){
                            Text(moodExperiment.name)
                        }
                    }
                }
                
                
            }
            .navigationTitle("Experiments")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("New Experiment"){
                        isPresentingSheetView = true
                    }
                }
                
            }
            .sheet(isPresented: $isPresentingSheetView){
                NavigationStack{
                    NewExperimentView(appData: $appData, isPresentingSheetView: $isPresentingSheetView)
                        .navigationTitle("New Experiment")
                        .toolbar{
                            ToolbarItem(placement: .confirmationAction){
                                Button("Done"){
                                    //add the new experiment to the app data
                                    isPresentingSheetView = false
                                }
                            }
                        }
                }
            }
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
