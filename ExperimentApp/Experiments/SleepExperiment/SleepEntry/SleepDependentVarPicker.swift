//
//  SleepOptionalPicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI
//used for picking quality of day and productivity of sleep entries
//if the optional does not exist, it will display -
//as soon as the picker is interacted with, it will assign a value to the optional

//idea: use 0 to encode hasn't interacted with it
struct SleepDependentVarPicker: View {
    var label: String
    @State var value: Int = 0
    @Binding var optional: Int?
    var image: String = "sun.max"

    var body: some View {
        HStack{
            Image(systemName: image)
            if let optionalValue = optional{
                Picker(label, selection: $value){
                    ForEach(1..<11, id:\.self){ number in
                        Text("\(number)").tag(number)
                    }
                }.onAppear(){
                    value = optionalValue
                }
            } else {
                HStack{
                    Picker(label, selection: $value){
                        ForEach(0..<11, id:\.self){ number in
                            if(number == 0){
                                Text("-").tag(0)
                            } else {
                                Text("\(number)").tag(number)
                            }
                        }
                    }
                    .id(value)
                }.onAppear(){
                    value = 0
                }
            }
        }.onChange(of: value){ newValue in
            if(newValue != 0){
                optional = newValue
            }
        }
        
    }
}

struct SleepOptionalPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Form{
                SleepDependentVarPicker(label: "Quality of day", optional: .constant(nil))
            }
        }
    }
}
