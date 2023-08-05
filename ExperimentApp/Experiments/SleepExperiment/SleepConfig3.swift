//
//  SleepConfig3.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
//

import SwiftUI

struct SleepConfig3: View {
    let independentConfig: IndependentVariable
    let dependentConfig: DependentVariable
    @State var sliderValue: Double = 20
    @State var entries: Int = 20
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Text("You chose \(dependentConfig.rawValue)")
            Text("Finally, choose a goal amount of entries")
            HStack{
                Slider(value: $sliderValue, in: 5...40, step: 0.1).onChange(of: sliderValue) { newValue in
                    entries = Int(newValue)
                }
                Text("\(entries)")
            }
            Button("Return to Main View") {
                presentationMode.wrappedValue.dismiss()
                presentationMode.wrappedValue.dismiss()
                presentationMode.wrappedValue.dismiss()
                presentationMode.wrappedValue.dismiss()
            }
            //doesn't work yet
        }
        
    }
}

struct SleepConfig3_Previews: PreviewProvider {
    static var previews: some View {
        SleepConfig3(independentConfig: .both, dependentConfig: .productivity)
    }
}
