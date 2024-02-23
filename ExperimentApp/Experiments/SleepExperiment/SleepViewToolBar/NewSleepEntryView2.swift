//
//  NewSleepEntryView2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

struct NewSleepEntryView2: View {
    @Binding var experiment: SleepExperiment
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        NavigationStack{
            Form{
                NewSleepEntryView(experiment: $experiment)
                
            }.navigationTitle("New Sleep Entry")
                .toolbar{
                    ToolbarItem(placement:.navigationBarTrailing){
                        Button(action:{
                            presentationMode.wrappedValue.dismiss()
                        },label: {
                            Text("Save")
                        })
                    }
                }.onAppear(){
                    experiment.isEditing = true
                }.buttonStyle(.borderless)
        }
    }
}

struct NewSleepEntryView2_Previews: PreviewProvider {
    static var previews: some View {
        NewSleepEntryView2(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))
    }
}
