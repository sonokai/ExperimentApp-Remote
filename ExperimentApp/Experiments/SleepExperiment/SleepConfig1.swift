//
//  SleepConfig1.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
//

import SwiftUI



struct SleepConfig1: View {
    
    @Binding var independentVariable: SleepExperiment.IndependentVariable
    @State var hasSelected = false
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("Choose how you'd like to track your sleep.")
                    .padding(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                
                
                ForEach(SleepExperiment.IndependentVariable.allCases){ variable in
                    
                    HStack{
                        
                        VStack{
                            Text(variable.name).frame(maxWidth: .infinity, alignment: .leading)
                            //enter a description for each of the choices
                            switch(variable.name){
                            case "Bedtime":
                                Text("Enter the time you went to bed the night before")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            case "Waketime":
                                Text("Enter the time you woke up in the morning")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            case "Both":
                                Text("Enter both bedtime and wake time, and the app calculates time slept")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            case "Hours Slept":
                                Text("Give a rough estimate of time slept the night before")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                            default:
                                Text("default")
                            }
                        }
                        Spacer()
                        //display a button saying choose if not chosen already, display selected if chosen
                        if(hasSelected == false || independentVariable != variable){
                            Button("Choose"){
                                independentVariable = variable
                                hasSelected = true
                                print(variable.name)
                            }
                        } else {
                            Text("Selected")
                        }
                    }
                    
                    
                    
                }.buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                
                //this doesn't work because the button just assigns the selected value to the last possible case idk how to fix so we will just use inefficient code
                //it actually does work if we use .buttonStyle(BorderlessButtonStyle() bc for some reason using a button in form presses every single button in it
                /*
                 
                 HStack{
                 
                 Text("Bedtime")
                 Spacer()
                 if(hasSelected == false || independentVariable != .bedtime){
                 Button("Choose"){
                 independentVariable = .bedtime
                 hasSelected = true
                 }
                 } else {
                 Text("Selected")
                 }
                 
                 }.padding(.horizontal)
                 
                 HStack{
                 
                 Text("Waketime")
                 Spacer()
                 if(hasSelected == false || independentVariable != .waketime){
                 Button("Choose"){
                 independentVariable = .waketime
                 hasSelected = true
                 }
                 } else {
                 Text("Selected")
                 }
                 
                 }.padding(.horizontal)
                 
                 HStack{
                 
                 Text("Both bedtime and waketime")
                 Spacer()
                 if(hasSelected == false || independentVariable != .both){
                 Button("Choose"){
                 independentVariable = .both
                 hasSelected = true
                 }
                 } else {
                 Text("Selected")
                 }
                 
                 }.padding(.horizontal)
                 
                 HStack{
                 
                 Text("Hours slept")
                 Spacer()
                 if(hasSelected == false || independentVariable != .hoursSlept){
                 Button("Choose"){
                 independentVariable = .hoursSlept
                 hasSelected = true
                 }
                 } else {
                 Text("Selected")
                 }
                 
                 }.padding(.horizontal)
                 
                 */
                
                
                
            }
        }
    }
}

struct SleepConfig1_Previews: PreviewProvider {
    static var previews: some View {
        SleepConfig1(independentVariable: .constant(SleepExperiment.IndependentVariable.bedtime))
    }
}
