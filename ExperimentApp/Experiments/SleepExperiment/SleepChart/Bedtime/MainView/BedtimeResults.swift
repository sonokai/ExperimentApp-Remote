//
//  SleepStats.swift
//  ExperimentApp
//
//  Created by Bell Chen on 10/19/23.
//

import SwiftUI

struct BedtimeResults: View {
    var experiment: SleepExperiment
    var body: some View {
        NavigationStack{
            Form{
                Section("Correlational data"){
                    BedtimeCorrelationData(experiment: experiment)
                }
                
                if(experiment.entries.count>0){
                    Section("Independent variable data"){
                        BedtimeData(experiment: experiment)
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

struct SleepStats_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            BedtimeResults(experiment: SleepExperiment.bedtimeSampleExperiment)
        }
    }
}
