//
//  ExperimentAppApp.swift
//  ExperimentApp
//
//  Created by Kai Green on 7/7/23.
//

import SwiftUI

@main
struct ExperimentAppApp: App {
    @State private var sleepEntries: [SleepEntry] = SleepEntry.sampleData
    @State private var dayExperiment: DayExperiment = DayExperiment.sampleExperiment
    @State private var sleepExperiments: [SleepExperiment] = []
    
    @StateObject private var store = DataStore()
    
    var body: some Scene {
        WindowGroup {
            ExperimentView2(appData: $store.data){
                //we want to have experimentview(data: $store.data)
                Task {
                    do {
                        try await store.save(appdata: store.data)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task{
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            
            
        }
    }
}
