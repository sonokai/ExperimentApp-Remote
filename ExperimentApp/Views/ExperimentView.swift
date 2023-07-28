//
//  ExperimentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/28/23.
//

import SwiftUI

struct ExperimentView: View {
    
    
    @Binding var sleepEntries: [IntEntry]
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Experiments")){
                    NavigationLink(destination: SleepView2(entries:$sleepEntries)){
                        Text("Sleep Experiment")
                    }
                }
            
            }
        }.navigationTitle("Experiments")
    }
    
    struct ExperimentView_Previews: PreviewProvider {
        static var previews: some View {
            ExperimentView(sleepEntries: .constant(IntEntry.sampleData))
        }
    }
}
