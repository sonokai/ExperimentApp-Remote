//
//  SleepIntroView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/3/23.
//

import SwiftUI

struct SleepIntroView: View {
    @Binding var sleepExperiments: [SleepExperiment]
    @Environment(\.presentationMode) var presentationMode
    @State var goalEntries: Int = 5  //ask user how many entries they want to have
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality //ask user if they want to track how sleep affects their productivity or quality of day
    @State var independentVariable: SleepExperiment.IndependentVariable = .bedtime //ask user if they want to guess how much hours they slept on their own or only track bedtime, waketime, or both bedtime and waketime for the maximum data
    
    
    @State var name: String = ""
    
    var body: some View {
        NavigationStack{
            Form{
                
                Text("Let's set up your sleep experiment.").font(.headline)
                SleepSetup1(independentVariable: $independentVariable)
                SleepSetup2(dependentVariable: $dependentVariable)
                SleepSetup3(goalEntries: $goalEntries)
                ExperimentNameView(name: $name, defaultValue: "Sleep Experiment")
                
                
            }
        }.toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button("Create experiment"){
                    
                    sleepExperiments.append(SleepExperiment(goalEntries: goalEntries, dependentVariable: dependentVariable, independentVariable: independentVariable, entries: [], name: name))
                }
            }
        }
    }
}

struct SleepIntroView_Previews: PreviewProvider {
    static var previews: some View {
        SleepIntroView(sleepExperiments: .constant(SleepExperiment.experimentArray))
    }
}
