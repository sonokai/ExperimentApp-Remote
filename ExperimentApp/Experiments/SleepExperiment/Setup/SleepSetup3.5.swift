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
        VStack(alignment:.leading){
            Text("Name").font(.largeTitle).bold()
            Text("Enter a name for your experiment (optional)").padding(1)
            TextField("Sleep experiment", text: $text)
            Spacer()
            HStack{
                Button("Back"){
                    withAnimation{
                        index = 4
                    }
                }
                Spacer()
                Button("Next"){
                    withAnimation{
                        index = 6
                    }
                }
            }
            
        }.padding()
    }
}

struct SleepSetup3_5_Previews: PreviewProvider {
    static var previews: some View {
        SleepSetup3_5(text: .constant(""), index: .constant(4))
    }
}
