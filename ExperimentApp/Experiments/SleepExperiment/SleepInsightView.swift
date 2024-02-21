//
//  SleepInsightView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

struct SleepInsightView: View {
    @Binding var experiment: SleepExperiment
    var body: some View {
        NavigationStack{
            Form{
                ForEach($experiment.insights, id: \.self){ $insight in
                    NavigationLink(destination: SleepInsightEditView(insight: $insight, text: insight.text)){
                        VStack(alignment: .leading){
                            Text(Date.formatToMonthAndDay(date: insight.date)).bold()
                            Text(insight.text)
                        }
                    }
                }
                NavigationLink(destination: NewSleepInsightView(experiment: $experiment)){
                    Text("Add a new insight")
                }
            }.navigationTitle("Insights")
        }
    }
}

struct SleepInsightView_Previews: PreviewProvider {
    static var previews: some View {
        SleepInsightView(experiment: .constant(SleepExperiment.bedtimebothExperiment))
    }
}
