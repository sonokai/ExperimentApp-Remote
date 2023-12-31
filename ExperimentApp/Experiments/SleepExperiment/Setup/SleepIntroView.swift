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
    @State var index: Int = 0
    
    @State var name: String = ""
    @Binding var selectedTabIndex: Int
    
    @State var isCreatingExperiment: Bool = false
    var body: some View {
        NavigationStack{
            Form{
                
                Text("Let's set up your sleep experiment.").font(.headline)
                
                SleepSetup1(independentVariable: $independentVariable, index: $index)
                
                if(index > 0){
                    SleepSetup2(dependentVariable: $dependentVariable, index: $index)
                }
                if(index > 1){
                    SleepSetup3(goalEntries: $goalEntries, index: $index)
                }
                if(index > 2){
                    ExperimentNameView(name: $name, defaultValue: "Sleep Experiment")
                    Button("Create experiment"){
                        
                        sleepExperiments.append(SleepExperiment(goalEntries: goalEntries, dependentVariable: dependentVariable, independentVariable: independentVariable, entries: [], name: name))
                        isCreatingExperiment = true
                        presentationMode.wrappedValue.dismiss()
                    }.onDisappear(){
                        selectedTabIndex = 0
                    }
                }
            }
        }
    }
}

struct SleepIntroView_Previews: PreviewProvider {
    static var previews: some View {
        SleepIntroView(sleepExperiments: .constant(SleepExperiment.experimentArray), selectedTabIndex: .constant(0))
    }
}
