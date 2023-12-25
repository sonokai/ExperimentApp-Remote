//
//  NewSleepInsightView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

struct NewSleepInsightView: View {
    @Binding var experiment: SleepExperiment
    @State var text: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack{
            Form{
                Section("Write your new insight here"){
                    TextEditor(text: $text).frame(minHeight: 150)
                }
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Done"){
                        experiment.insights.append(text)
                        presentationMode.wrappedValue.dismiss()
                    }.disabled(text == "")
                }
            }.navigationTitle("New insight")
        }
    }
}

struct NewSleepInsightView_Previews: PreviewProvider {
    static var previews: some View {
        NewSleepInsightView(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))
    }
}
