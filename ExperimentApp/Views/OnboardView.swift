//
//  OnboardView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/21/24.
//

import SwiftUI

struct OnboardView: View {
    @Binding var isFirstLaunch: Bool
    var action: () -> Void
    var body: some View {
        VStack(alignment:.leading, spacing: 15){
            Text("What is Logarithm?").bold().font(.largeTitle)
            Text("Logarithm has three components:").font(.headline)
            VStack(alignment:.leading, spacing: 5){
                Text("1. Exploration: find questions to ask yourself.")
                Text(" - What time should you go to bed if you want to be the most productive the next day?").font(.caption)
                Text(" - How much does your personality change over the course of a year?").font(.caption)
                Text(" - How does weather affect your mood?").font(.caption)
                Text("We looked for questions with applicable answers that are also relatively convienient to self-report.").font(.caption)
            }
            Text("2. Experimentation: log your entries.")
            VStack(alignment: .leading, spacing: 5){
                Text("In this step you'll enter entries, which contain an independent variable and dependent variable.").font(.caption)
            }
            Text("3.") + Text(" Analysis") + Text(": look at the data to learn something new.")
            VStack(alignment: .leading, spacing: 5){
                Text("We'll make some charts to display the associations between the measured variables.").font(.caption)
                Text("Based on what you learned from the charts and the data you collected, you can write down insights.").font(.caption)
                Text("We'll also do the math and generate some insights for you.").font(.caption)
                Text("Insights will be preserved after you complete the experiment for you to look back at").font(.caption)
            }
            Spacer()
            Button("Let's begin"){
                action()
                isFirstLaunch = false
                print("User onboard complete")
            }
        }.padding()
        
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView(isFirstLaunch: .constant(false), action: {})
    }
}
