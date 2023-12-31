//
//  SleepView3.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
// a version of sleep experiment that can customize name, notes, type of variables upon config 


import SwiftUI

struct SleepView: View {
    @Binding var experiment: SleepExperiment
    @State private var isAddingNew = false
    @State private var newEntry = SleepEntry.newEntry
    
    var body: some View {
        
        
        
        NavigationStack{
            
            Form{
                Section("Make a new entry"){
                    NewSleepEntryView(experiment: $experiment)
                }
                
                Section("Results"){
                    NavigationLink(destination: SleepProcedureView(experiment: experiment)){
                        Text("Procedure")
                    }
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
            
            
            
            
        }.sheet(isPresented: $isAddingNew) {
            
            NavigationStack {
                
                SleepEditView(entry: $experiment.entries[experiment.entries.count-1], experiment: $experiment)// return the last item in entries because when the button was pressed, an empty entry was added
                    .navigationTitle("New Entry")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isAddingNew = false
                                experiment.entries.removeLast()
                            }
                        }
                    }
            }
            
        }.toolbar {
            Button("New entry") {
                experiment.entries.append(newEntry)
                //immediately add a new entry and present a sleepeditview as a sheet to edit that entry'
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    isAddingNew = true
                }
            }
            
            
        }
    }
    
}


struct SleepView3_Previews: PreviewProvider {
    static var previews: some View {
        SleepView(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))
    }
}
