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
    
    @State var entries: Int = 20
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            Text("You chose \(dependentConfig.rawValue)")
            Text("Finally, choose a goal amount of entries")
            
            Button("Return to Main View") {
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
