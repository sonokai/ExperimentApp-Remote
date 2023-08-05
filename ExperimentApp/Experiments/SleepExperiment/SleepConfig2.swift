//
//  SleepConfig2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
//

import SwiftUI

struct SleepConfig2: View {
    let independentConfig: IndependentVariable
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack{
            VStack{
                Text("You chose to track \(independentConfig.rawValue)")
                
                
                Text("Next, choose a question (or both).")
                
                NavigationLink(destination: SleepConfig3(independentConfig: independentConfig, dependentConfig: .productivity)){
                    Text("How does \(independentConfig.rawValue) affect my productivity the next day?")
                }
                NavigationLink(destination: SleepConfig3(independentConfig: independentConfig, dependentConfig: .quality)){
                    Text("How does \(independentConfig.rawValue) affect the quality of my next day?")
                }
                NavigationLink(destination: SleepConfig3(independentConfig: independentConfig, dependentConfig: .both)){
                    Text("Both questions")
                }
                ProgressView(value: 2, total: 3)
                Text("Page 2/3")
            }
        }
    }
}

struct SleepConfig2_Previews: PreviewProvider {
    static var previews: some View {
        SleepConfig2(independentConfig: .bedtime)
        
    }
}
