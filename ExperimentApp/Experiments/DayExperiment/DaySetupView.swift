//
//  DaySetupView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/2/23.
//

import SwiftUI

struct DaySetupView: View {
    @Binding var dayExperiments: [DayExperiment]
    @State var independentVariables: DayExperiment.IndependentVariable = DayExperiment.sampleIndependentVariable
    @State var dependentVariable: DayExperiment.DependentVariable = .focus
    @State var goalEntries: Int = 10
    @State var name: String = " Day Expperiment"
    var body: some View {
        NavigationStack{
            Form{
                Text("Let's set up your day experiment.")
                DaySetup1(independentVariable: $independentVariables)
                DaySetup2(dependentVariable: $dependentVariable)
                DaySetup3(goalEntries: $goalEntries)
                
                
                
            }
        }
    }
}

struct DaySetupView_Previews: PreviewProvider {
    static var previews: some View {
        DaySetupView(dayExperiments: .constant(DayExperiment.sampleExperimentArray))
    }
}
