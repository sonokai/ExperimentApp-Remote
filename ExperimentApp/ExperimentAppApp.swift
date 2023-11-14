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
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ExperimentView(appData: $store.data){
                
                Task {
                    do {
                        try await store.save(appdata: store.data)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Something with the saving went wrong")
                    }
                }
            }
            .task{
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Something with the file loading went wrong")
                }
            }.sheet(item: $errorWrapper) {
                
                store.data = AppData.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
            
            
        }
    }
}
