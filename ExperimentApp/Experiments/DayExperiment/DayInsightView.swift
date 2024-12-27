//
//  DayInsightView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 3/31/24.
//

import SwiftUI

struct DayInsightView: View {
    var experiment: DayExperiment
    var body: some View {
        Form{
            Text("What have you learned from your experiment?")
        }
    }
}

struct DayInsightView_Previews: PreviewProvider {
    static var previews: some View {
        DayInsightView(experiment: DayExperiment.sampleExperiment)
    }
}
