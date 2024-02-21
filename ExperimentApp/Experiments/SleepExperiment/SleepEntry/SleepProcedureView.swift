//
//  SleepProcedureView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/26/23.
//

import SwiftUI

struct SleepProcedureView: View {
    var experiment: SleepExperiment
    @Binding var sheet: Bool
    var body: some View {
        NavigationStack{
            Form{
                //independentvariable: bedtime, wake time, both, hours slept
                //dependentvariables: quality of day, productivity, both
                switch(experiment.independentVariable){
                case .bedtime:
                    Text("Right before you sleep, make an entry when you go to bed and log the time.")
                case .waketime:
                    Text("When you wake up in the morning, make an entry and log the time.")
                case .both:
                    Text("Every day before you sleep, make an entry when you go to bed and log the time.")
                    Text("The next day, open last night's entry and log the time when you wake up.")
                case .hoursSlept:
                    Text("When you wake up in the morning, make a new entry and log your total time slept.")
                }
                
                switch(experiment.dependentVariable){
                case .productivity:
                    Text("At the end of the day, rate your productivity during the day on a scale of 1-10.")
                case .quality:
                    Text("At the end of the day, rate the quality of your day on a scale of 1-10.")
                case .both:
                    Text("At the end of the day, give the quality and productivity of your day a score of 1-10.")
                }
                
                Text("Repeat \(experiment.goalEntries) times and analyze the results!")
            }.toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Done"){
                        sheet.toggle()
                    }
                }
            }.navigationTitle("Procedure")
        }
        
    }
}

struct SleepProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        SleepProcedureView(experiment: SleepExperiment.bedtimeSampleExperiment, sheet: .constant(true))
    }
}
