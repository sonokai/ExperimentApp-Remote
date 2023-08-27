//
//  ExperimentView2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/27/23.
//

import SwiftUI

struct ExperimentView2: View {
    @Environment (\.scenePhase) private var scenePhase
    let saveAction : () -> Void
    @Binding var appData: AppData
    @State var isPresentingSheetView = false
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Active Experiments")){
                    ForEach($appData.sleepExperiments) { $sleepExperiment in
                        NavigationLink(destination: SleepView3(sleepExperiment: $sleepExperiment)){
                            Text("\(sleepExperiment.name)")
                        }
                    }
                    ForEach($appData.dayExperiments) { $dayExperiment in
                        NavigationLink(destination:DayView(dayExperiment: $dayExperiment)){
                            Text("\(dayExperiment.name)")
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
                    NewExperimentView(appData: $appData)
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
        ExperimentView2(saveAction: {}, appData: .constant(AppData.sampleData))
    }
}
