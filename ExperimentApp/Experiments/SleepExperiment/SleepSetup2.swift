//
//  SleepConfig2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
//

import SwiftUI

struct SleepSetup2: View {
    
    
    @Binding var dependentVariable: SleepExperiment.DependentVariable
    @State var hasSelected = false
    var body: some View {
        
        NavigationStack{
            
            VStack{
                Text("Choose a question.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .padding(1)
                ForEach(SleepExperiment.DependentVariable.allCases){ variable in
                        HStack{
                            VStack{
                                Text(variable.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                switch(variable.name){
                                case "Productivity":
                                    Text("How do my sleep patterns affect my productivity?")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.caption)
                                case "Quality":
                                    Text("How do my sleep patterns affect the quality of my day?")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.caption)
                                case "Both":
                                    Text("How do my sleep patterns affect my productivity and my quality of day?")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.caption)
                                default:
                                    Text("default")
                                }
                            }
                            Spacer()
                            if(hasSelected == false || dependentVariable != variable){
                                Button("Choose"){
                                    dependentVariable = variable
                                    hasSelected = true
                                }
                            } else {
                                Text("Selected")
                            }
                            
                            
                            
                        }
                        
                        .padding(1)
                       
                        
                    
                    
                }.buttonStyle(.borderless)
                
            }
        }
    }
}

struct SleepConfig2_Previews: PreviewProvider {
    static var previews: some View {
        SleepSetup2(dependentVariable: .constant(.both))
        
    }
}
