//
//  ContentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    @Environment (\.scenePhase) private var scenePhase
    @State private var selectedTabIndex = 0
    @Binding var appData: AppData
    @State var isPresentingSheetView = false
    let saveAction : () -> Void
    var body: some View {
        TabView(selection: $selectedTabIndex){
            ExperimentView(appData: $appData, saveAction: saveAction, selectedTabIndex: $selectedTabIndex)
                .tag(0)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            NewExperimentView(appData: $appData, selectedTabIndex: $selectedTabIndex)
                .tag(1)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            ProfileView(appData: $appData)
                .tag(2)
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
