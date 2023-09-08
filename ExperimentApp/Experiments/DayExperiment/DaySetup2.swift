//
//  DaySetup2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/3/23.
//

import SwiftUI

struct DaySetup2: View {
    @Binding var dependentVariable: DayExperiment.DependentVariable
    @Binding var hasSelectedDependentVariable: Bool
    var body: some View {
        VStack{
            Text("Choose a dependent variable")
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            ForEach(DayExperiment.DependentVariable.allCases){ variable in
                HStack{
                    VStack{
                        Text(variable.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        switch(variable){
                        case .plannedToDoneRatio:
                            Text("Take the ratio of how much you planned to get done and how much you actually got done")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                        case .focus:
                            Text("Record how focused you were during your work session")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                        case .time:
                            Text("Record how much time you worked (only pick if working for long periods is something inconsistent)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                        
                        }
                        
                    }
                    
                    
                    if(hasSelectedDependentVariable == false || dependentVariable != variable){
                        Spacer().frame(maxWidth: 50)
                        Button("Choose"){
                            dependentVariable = variable
                            hasSelectedDependentVariable = true
                        }.buttonStyle(.borderless)
                    } else {
                        Spacer().frame(maxWidth:10)
                        Text("Selected")
                    }
                    
                }
                
                    
            }
            .padding(1)
        }
    }
    
}

struct DaySetup2_Previews: PreviewProvider {
    static var previews: some View {
        DaySetup2(dependentVariable: .constant(.focus), hasSelectedDependentVariable: .constant(false))
    }
}
