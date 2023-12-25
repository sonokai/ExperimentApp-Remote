//
//  SleepInsightView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

struct SleepInsightView: View {
    @Binding var experiment: SleepExperiment
    var body: some View {
        ForEach(experiment.insights, id: \.self){ insight in
            Text(insight)
        }
        NavigationLink(destination: NewSleepInsightView(experiment: $experiment)){
            Text("Add a new insight")
        }
    }
}

struct SleepInsightView_Previews: PreviewProvider {
    static var previews: some View {
        SleepInsightView(experiment: .constant(SleepExperiment.bedtimebothExperiment))
    }
}
