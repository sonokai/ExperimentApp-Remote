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
    @State private var dayEntries: [DayEntry] = DayEntry.sampleData
    var body: some Scene {
        WindowGroup {
            ExperimentView(sleepEntries: $sleepEntries, dayEntries: $dayEntries)
        }
    }
}
