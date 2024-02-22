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
                
                if(experiment.entries.count>0){
                    Section("Independent variable data"){
                        BothTimeData(experiment: experiment)
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

struct BothTimeResults_Previews: PreviewProvider {
    
    static var previews: some View {
        BothTimeResults(experiment: SleepExperiment.bothTimesSampleExperiment)
    }
}
