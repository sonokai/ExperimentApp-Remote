//
//  ContentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    @Environment (\.scenePhase) private var scenePhase
    @AppStorage("selectedTab") var selectedTabIndex: Int = 0
    @StateObject private var viewModel = TabViewModel()
    @Binding var appData: AppData
    @State var isPresentingSheetView = false
    let saveAction : () -> Void
    var body: some View {
        TabView(selection: $viewModel.selectedTab){
            ExperimentView(appData: $appData, saveAction: saveAction, selectedTabIndex: $viewModel.selectedTab)
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
class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appData: .constant(AppData.sampleData), saveAction: {})
    }
}
