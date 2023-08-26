//
//  SleepIntroView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/3/23.
//

import SwiftUI

struct SleepIntroView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var goalEntries: Int = 5 //ask user how many entries they want to have
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality //ask user if they want to track how sleep affects their productivity or quality of day
    @State var independentVariable: SleepExperiment.IndependentVariable = .bedtime //ask user if they want to guess how much hours they slept on their own or only track bedtime, waketime, or both bedtime and waketime for the maximum data
    @State var entries: [SleepEntry] = []
    @State var notes: String = "Take notes here"
    @State var name: String = "Sleep Experiment"
    var body: some View {
        NavigationStack{
            VStack{
                Text("Let's set up your sleep experiment.")
                NavigationLink(destination: SleepConfig1()){
                    Text("Begin")
                }
                
                
                
            }
        }
    }
}

struct SleepIntroView_Previews: PreviewProvider {
    static var previews: some View {
        SleepIntroView()
    }
}
