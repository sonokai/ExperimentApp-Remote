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
    @Binding var isPresentingSheetView : Bool
    
    let experimentDescription: String = ""
    
    var body: some View {
        NavigationStack{
            Form{
                DescriptionView(headline: "Let's set up your day experiment", description: "hahhahaha")
                DaySetup1(independentVariable: $independentVariable)
                DaySetup2(dependentVariable: $dependentVariable, hasSelectedDependentVariable: $hasSelectedDependentVariable)
                DaySetup3(goalEntries: $goalEntries)
                ExperimentNameView(name: $name, defaultValue: "Day Experiment")
                
                
                
            }
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Create experiment"){
                        isPresentingSheetView = false
                        dayExperiments.append(DayExperiment(goalEntries: goalEntries,independentVariable: independentVariable, dependentVariable: dependentVariable, entries: [], name: name, notes: ""))
                    }.disabled(independentVariable.times == []||independentVariable.hasEmptyCustomTimes() || !hasSelectedDependentVariable)
                }
            }
        }
    }
}

struct DaySetupView_Previews: PreviewProvider {
    static var previews: some View {
        DaySetupView(dayExperiments: .constant(DayExperiment.sampleExperimentArray), isPresentingSheetView: .constant(true))
    }
}
