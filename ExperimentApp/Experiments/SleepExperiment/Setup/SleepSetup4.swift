//
//  SleepSetup4.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/20/24.
//

import SwiftUI

struct SleepSetup4: View {
    let finishAction: () -> Void
    var independentVariable: SleepExperiment.IndependentVariable
    var dependentVariable: SleepExperiment.DependentVariable
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Final steps").font(.largeTitle).bold()
            Text("Here is the procedure you will be following:").bold()
            switch(independentVariable){
            case .bedtime:
                Text("1. Right before you sleep, make an entry and log the time.")
            case .waketime:
                Text("1. When you wake up in the morning, make an entry and log the time.")
            case .both:
                Text("1. Every day before you sleep, make an entry you go to bed and log the time.")
                Text("The next day, open last night's entry and log the time when you wake up.")
            case .hoursSlept:
                Text("1. When you wake up in the morning, make a new entry and log your total time slept.")
            }
            switch(dependentVariable){
            case .productivity:
                Text("2. At the end of the day, rate your productivity during the day on a scale of 1-10.")
            case .quality:
                Text("2. At the end of the day, rate the quality of your day on a scale of 1-10.")
            case .both:
                Text("2. At the end of the day, give the quality and productivity of your day a score of 1-10.")
            }
            
            switch(independentVariable){
            case .bedtime:
                Text("3. Analyze the results using the Logarithm app and find the best bedtime.")
            case .waketime:
                Text("3. Analyze the results using the Logarithm app and find the best time to wake up")
            case .both:
                Text("3. Analyze the results using the Logarithm app and find the best bedtime, wake time, and total sleep time.")
            case .hoursSlept:
                Text("3. Analyze the results using the Logarithm app and find best amount of time to sleep per night.")
            }
            Text("If this all sounds good, then start the experiment.")
            Button("Start experiment"){
                finishAction()
            }
            Spacer()
            
        }.padding()
    }
}

struct SleepSetup4_Previews: PreviewProvider {
    static var previews: some View {
        SleepSetup4(finishAction: {}, independentVariable: .bedtime, dependentVariable: .productivity)
    }
}
