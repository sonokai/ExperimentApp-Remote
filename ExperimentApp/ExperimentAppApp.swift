//
//  ExperimentAppApp.swift
//  ExperimentApp
//
//  Created by Kai Green on 7/7/23.
//

import SwiftUI

@main
struct ExperimentAppApp: App {
    @StateObject private var store = DataStore()
    
    var body: some Scene {
        WindowGroup {
            ExperimentView(appData: $store.data){
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
