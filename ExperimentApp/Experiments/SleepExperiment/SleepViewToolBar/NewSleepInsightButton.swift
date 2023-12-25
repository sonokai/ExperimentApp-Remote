//
//  NewSleepInsightButton.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

struct NewSleepInsightButton: View {
    @Binding var experiment: SleepExperiment
    var body: some View {
        NavigationLink(destination: NewSleepInsightView(experiment: $experiment)){
            Image(systemName: "square.and.pencil")
        }
    }
}


