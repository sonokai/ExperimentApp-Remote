//
//  SleepSetup3.5.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/22/24.
//

import SwiftUI

struct SleepSetup3_5: View {
    @Binding var text: String
    @Binding var index: Int
    var body: some View {
        VStack{
            Text("Enter a name for your experiment")
            
        }
    }
}

struct SleepSetup3_5_Previews: PreviewProvider {
    static var previews: some View {
        SleepSetup3_5(text: .constant(""), index: .constant(4))
    }
}
