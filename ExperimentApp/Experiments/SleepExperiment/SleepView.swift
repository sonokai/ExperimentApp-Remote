//
//  SleepView3.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
// a version of sleep experiment that can customize name, notes, type of variables upon config 


import SwiftUI

struct SleepView: View {
    @Binding var sleepExperiment: SleepExperiment
    @State private var isAddingNew = false
    @State private var newEntry = SleepEntry.newEntry
    
    var body: some View {
    
        
        
        NavigationStack{
            
            Form{
                Section(header: Text("Experiment Info")){
                    Text("Q: How much sleep should you get?")
                        .toolbar {
                        Button("New entry") {
                            sleepExperiment.entries.append(newEntry)
                            //immediately add a new entry and present a sleepeditview as a sheet to edit that entry'
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                isAddingNew = true
                            }
                        }
                    }
                    
                    NavigationLink(destination: SleepProcedureView()){
                        Text("Procedure")
                    }
                    NavigationLink(destination: Text("in development lol")){
                        Text("Results")
                    }
                    NavigationLink(destination: Text("\(sleepExperiment.notes)")){
                        Text("Notes")
                    }
                }
                .navigationTitle(Text("\(sleepExperiment.name)"))
                
                
                Section(header: Text("Entries")) {
                    
                    ForEach($sleepExperiment.entries) { entryBinding in
                        NavigationLink(destination: SleepEditView(entry:entryBinding, sleepExperiment: sleepExperiment).navigationTitle("Edit entry")) {
                            SimplifiedSleepView(sleepExperiment: sleepExperiment, entry: entryBinding)
                        }
                    }
                    .onDelete { indices in
                        deleteEntries(at: indices)
                    }
                     
                    
                }
                                
            }.sheet(isPresented: $isAddingNew) {
                
                NavigationStack {
                    
                    SleepEditView(entry: $sleepExperiment.entries[sleepExperiment.entries.count-1], sleepExperiment: sleepExperiment)// return the last item in entries because when the button was pressed, an empty entry was added
                        .navigationTitle("New Entry")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isAddingNew = false
                                    sleepExperiment.entries.removeLast()
                                }
                            }
                        }
                }
                 
            }

            
        }
    }
    private func deleteEntries(at indices: IndexSet) {
        sleepExperiment.entries.remove(atOffsets: indices)
    }
}


struct SleepView3_Previews: PreviewProvider {
    static var previews: some View {
        SleepView(sleepExperiment: .constant(SleepExperiment.bedtimeSampleExperiment))
    }
}
