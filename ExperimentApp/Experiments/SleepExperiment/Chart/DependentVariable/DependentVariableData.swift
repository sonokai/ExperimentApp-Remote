//
//  DependentVariableData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/23/23.
//

import SwiftUI

struct DependentVariableData: View {
    var experiment: SleepExperiment
    var body: some View {
        if(experiment.entries.count>=1){
            if(experiment.dependentVariable == .both){
                NavigationLink(destination: SleepDependentHistory(experiment: experiment, dependentVariable: .quality)){
                    SimpleSleepDependentHistory(experiment: experiment, dependentVariable: .quality)
                }
                NavigationLink(destination: SleepDependentHistory(experiment: experiment, dependentVariable: .productivity)){
                    SimpleSleepDependentHistory(experiment: experiment, dependentVariable: .productivity)
                }
            }else{
                NavigationLink(destination: SleepDependentHistory(experiment: experiment)){
                    SimpleSleepDependentHistory(experiment: experiment)
                }
            }
        } else{
            EntryProgressView(count: experiment.entries.count, needed: 1, text: "to view dependent variable data")
        }
    }
}

struct DependentVariableData_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Form{
                DependentVariableData(experiment: SleepExperiment.bedtimeSampleExperiment)
            }
        }
    }
}
