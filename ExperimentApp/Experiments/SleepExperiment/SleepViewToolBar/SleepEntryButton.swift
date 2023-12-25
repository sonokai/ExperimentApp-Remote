//
//  SleepEntryButton.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

struct SleepEntryButton: View {
    @Binding var experiment: SleepExperiment
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        NavigationLink(destination:
            NewSleepEntryView2(experiment: $experiment)
        ){
            Image(systemName: "plus")
        }
        //hello
    }
}
