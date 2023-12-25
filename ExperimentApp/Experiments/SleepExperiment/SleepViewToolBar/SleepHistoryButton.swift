//
//  SleepHistoryButton.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

struct SleepHistoryButton: View {
    @Binding var experiment: SleepExperiment
    var body: some View {
        NavigationLink(destination: SleepHistory(experiment: $experiment)){
            Image(systemName: "slider.horizontal.3")
        }
    }
}
