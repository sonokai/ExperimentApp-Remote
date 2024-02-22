//
//  WaketimeStats.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/2/23.
//

import SwiftUI

struct WaketimeResults: View {
    var experiment: SleepExperiment
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Correlational data"){
                    WaketimeCorrelationData(experiment: experiment)
                }
                
                if(experiment.entries.count>0){
                    Section("Independent variable data"){
                        WaketimeData(experiment: experiment)
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

struct WaketimeStats_Previews: PreviewProvider {
    static var previews: some View {
        WaketimeResults(experiment: SleepExperiment.waketimeSampleExperiment)
    }
}
