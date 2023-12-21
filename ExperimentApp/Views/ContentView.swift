//
//  ContentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    @Environment (\.scenePhase) private var scenePhase
    
    @Binding var appData: AppData
    @State var isPresentingSheetView = false
    let saveAction : () -> Void
    var body: some View {
        TabView {
            ExperimentView(appData: $appData, saveAction: saveAction)
                .tabItem {
                    
                    Label("Home", systemImage: "house")
                }
            NewExperimentView(appData: $appData)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            Text("Notification")
                .tabItem {
                    Label("Me", systemImage: "person")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appData: .constant(AppData.sampleData), saveAction: {})
    }
}
