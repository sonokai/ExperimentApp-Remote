//
//  SleepConfig1.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
//

import SwiftUI



struct SleepSetup1: View {
    
    @Binding var independentVariable: SleepExperiment.IndependentVariable
    @State var selected: Bool = false
    @Binding var index: Int
    var body: some View {
        
        NavigationStack{
            
            VStack(alignment: .leading){
                Text("Independent Variable").font(.largeTitle).bold()
                Text("Choose how you'd like to track your sleep.")
                    .padding(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                
                
                ForEach(SleepExperiment.IndependentVariable.allCases){ variable in
                    
                    HStack{
                        
                        VStack(){
                            Text(variable.name).frame(maxWidth: .infinity, alignment: .leading)
                            //enter a description for each of the choices
                            switch(variable){
                            case .bedtime:
                                Text("- For people with consistent wake times but inconsistent bedtimes")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            case .waketime:
                                Text("- For people with consistent bedtimes but inconsistent wake times")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            case .both:
                                Text("- The app calculates time slept")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                                
                                Text("- Generates the most insights")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            case .hoursSlept:
                                Text("- Give a rough estimate of time slept")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                                Text("- Least effort required")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            }
                        }
                        Spacer()
                        //display a button saying choose if not chosen already, display selected if chosen
                        if(!selected || independentVariable != variable){
                            Button("Choose"){
                                independentVariable = variable
                                selected = true
                                
                            }
                        } else {
                            Text("Selected")
                        }
                        
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(1)
                Spacer()
                HStack{
                    Button("Back"){
                        withAnimation{
                            index = 1
                        }
                    }
                    Spacer()
                    
                    Button("Next"){
                        withAnimation{
                            index = 3
                        }
                    }.disabled(!selected)
                    
                }
                /*
                VStack(alignment: .leading){
                    Text("Things to keep in mind: ").bold().padding(.bottom,5)
                    Text("Difficulty")
                    Text(" - How feasible will it be to consistently track the data?").font(.caption)
                    Text(" - If ?").font(.caption)
                    Text("Applicability")
                    Text(" - How useful will knowledge about bedtime be for you?").font(.caption)
                    Text("")
                    Text(" - How convienient will it be to track the data?").font(.caption)
                }
                Text(" - How convienient will it be to track the data?").font(.caption)
                 */
              //  Spacer()
            }
        }.padding()
    }
}

struct SleepConfig1_Previews: PreviewProvider {
    static var previews: some View {
        SleepSetup1(independentVariable: .constant(SleepExperiment.IndependentVariable.bedtime), index: .constant(0))
    }
}
