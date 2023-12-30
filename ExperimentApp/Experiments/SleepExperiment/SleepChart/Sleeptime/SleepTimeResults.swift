//
//  SleepTimeResults.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/6/23.
//

import SwiftUI
//this is sleep time results
struct SleepTimeResults: View {
    var experiment: SleepExperiment
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Correlational data"){
                    SleepTimeCorrelationData(experiment: experiment)
                }
                Section("Independent variable data"){
                    SleepTimeData(experiment: experiment)
                }
                Section("Dependent variable data"){
                    DependentVariableData(experiment: experiment)
                }
                
            }
        }.navigationTitle(Text("Experiment results"))
    }
   
}

struct SleepTimeResults_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeResults(experiment: SleepExperiment.hoursSleptSampleExperiment)
    }
}
