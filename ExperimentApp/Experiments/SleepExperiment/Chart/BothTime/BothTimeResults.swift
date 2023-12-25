//
//  BothTimeResults.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI

struct BothTimeResults: View {
    var experiment: SleepExperiment
    @State var chartToShow: ChartPicker.pickerValues = .bedtime
    var body: some View {
        NavigationStack{
            Form{
                Section("Correlational data"){
                    BothTimeCorrelationData(experiment: experiment)
                }
                Section("Independent variable data"){
                    BothTimeData(experiment: experiment)
                }
                Section("Dependent variable data"){
                    DependentVariableData(experiment: experiment)
                }
                
            }
        }.navigationTitle(Text("Experiment results"))
    }
}

struct BothTimeResults_Previews: PreviewProvider {
    static var previews: some View {
        BothTimeResults(experiment: SleepExperiment.bothTimesSampleExperiment)
    }
}
