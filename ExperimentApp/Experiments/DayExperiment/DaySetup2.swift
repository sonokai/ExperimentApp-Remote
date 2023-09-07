//
//  DaySetup2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/3/23.
//

import SwiftUI

struct DaySetup2: View {
    @Binding var dependentVariable: DayExperiment.DependentVariable
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
                        case .focus:
                            Text("Record how focused you were during your work session")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                        case .time:
                            Text("description")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                        
                        }
                        
                    }
                    if(dependentVariable != variable){
                        Button("Add"){
                            dependentVariable = variable
                        }
                    } else {
                        Text("Selected")
                    }
                    
                }
                
                    
            }
            .padding(.horizontal)
            .padding(.vertical,1)
        }
    }
    
}

struct DaySetup2_Previews: PreviewProvider {
    static var previews: some View {
        DaySetup2(dependentVariable: .constant(.focus))
    }
}
