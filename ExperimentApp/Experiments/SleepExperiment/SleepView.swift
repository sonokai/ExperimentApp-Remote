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
                Section(header: Text("Experiment Info")){
                    Text("Q: How much sleep should you get?")
                        .toolbar {
                        Button("New entry") {
                            experiment.entries.append(newEntry)
                            //immediately add a new entry and present a sleepeditview as a sheet to edit that entry'
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                isAddingNew = true
                            }
                        }
                    }
                    
                    NavigationLink(destination: SleepProcedureView()){
                        Text("Procedure")
                    }
                    NavigationLink(destination: SleepChart(experiment: experiment)){
                        Text("Chart")
                    }
                    NavigationLink(destination: Text("\(experiment.notes)")){
                        Text("Notes")
                    }
                }
                .navigationTitle(Text("\(experiment.name)"))
                
                
                Section(header: Text("Entries")) {
                    
                    ForEach($experiment.entries) { entryBinding in
                        NavigationLink(destination: SleepEditView(entry:entryBinding, sleepExperiment: experiment).navigationTitle("Edit entry")) {
                            SimplifiedSleepView(sleepExperiment: experiment, entry: entryBinding)
                        }
                    }
                    .onDelete { indices in
                        deleteEntries(at: indices)
                    }
                     
                    
                }
                                
            }.sheet(isPresented: $isAddingNew) {
                
                NavigationStack {
                    
                    SleepEditView(entry: $experiment.entries[experiment.entries.count-1], sleepExperiment: experiment)// return the last item in entries because when the button was pressed, an empty entry was added
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
                 
            }

            
        }
    }
    private func deleteEntries(at indices: IndexSet) {
        experiment.entries.remove(atOffsets: indices)
    }
}


struct SleepView3_Previews: PreviewProvider {
    static var previews: some View {
        SleepView(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))
    }
}
