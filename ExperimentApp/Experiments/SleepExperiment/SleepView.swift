//
//  SleepView3.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
// a version of sleep experiment that can customize name, notes, type of variables upon config 


import SwiftUI

struct SleepView: View {
    @Binding var experiment: SleepExperiment

    var body: some View {
        
        
        
        NavigationStack{
            
            Form{
                Section("Results"){
                    NavigationLink(destination: SleepChart(experiment: experiment)){
                        Text("Chart")
                    }
                    NavigationLink(destination: Text("\(experiment.notes)")){
                        Text("Notes")
                    }
                    NavigationLink(destination: SleepHistory(experiment: $experiment)){
                        Text("History")
                    }
                }
            }
            .navigationTitle(Text("\(experiment.name)"))
        }
    }
    
}


struct SleepView3_Previews: PreviewProvider {
    static var previews: some View {
        SleepView(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))
    }
}
