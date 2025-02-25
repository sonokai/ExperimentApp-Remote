//
//  DaySetupView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/2/23.
//

import SwiftUI

struct DaySetupView: View {
    @Binding var dayExperiments: [DayExperiment]
    @State var independentVariable: DayExperiment.IndependentVariable = DayExperiment.sampleIndependentVariable
    @State var dependentVariable: DayExperiment.DependentVariable = .time
    @State var goalEntries: Int = 10
    @State var name: String = ""
    @State var hasSelectedDependentVariable = false
    
    
    let experimentDescription: String = ""
    
    var body: some View {
        NavigationStack{
            Form{
               
                DaySetup1(independentVariable: $independentVariable)
                DaySetup2(dependentVariable: $dependentVariable, hasSelectedDependentVariable: $hasSelectedDependentVariable)
                DaySetup3(goalEntries: $goalEntries)
                ExperimentNameView(name: $name, defaultValue: "Day Experiment")
                
                
                
            }
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Create experiment"){
                       
                        dayExperiments.append(DayExperiment(goalEntries: goalEntries,independentVariable: independentVariable, dependentVariable: dependentVariable, entries: [], name: name, notes: ""))
                    }.disabled(independentVariable.timesOfDayIsEmpty() || !hasSelectedDependentVariable)
                }
            }
        }
    }
}

struct DaySetupView_Previews: PreviewProvider {
    static var previews: some View {
        DaySetupView(dayExperiments: .constant(DayExperiment.sampleExperimentArray))
    }
}
