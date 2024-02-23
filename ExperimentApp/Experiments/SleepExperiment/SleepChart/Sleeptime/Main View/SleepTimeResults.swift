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
                if(experiment.entries.count>0){
                    Section("Independent variable data"){
                        SleepTimeData(experiment: experiment)
                    }
                    Section("Dependent variable data"){
                        DependentVariableData(experiment: experiment)
                    }
                } else {
                    Text("Charts will show up here once you add an entry.")
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
