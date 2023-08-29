//
//  SleepConfig4.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/29/23.
//

import SwiftUI

struct SleepConfig4: View {
    @Binding var name : String
    
    var body: some View {
        VStack{
            Text("Add a title for your experiment (optional)")
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            TextField("Sleep experiment" , text: $name)
        }
    }
}

struct SleepConfig4_Previews: PreviewProvider {
    static var previews: some View {
        SleepConfig4(name: .constant(""))
    }
}
