//
//  ExperimentAppApp.swift
//  ExperimentApp
//
//  Created by Kai Green on 7/7/23.
//

import SwiftUI

@main
struct ExperimentAppApp: App {
    @State private var sleepEntries: [IntEntry] = IntEntry.sampleData
    var body: some Scene {
        WindowGroup {
            ExperimentView(sleepEntries: $sleepEntries)
        }
    }
}
