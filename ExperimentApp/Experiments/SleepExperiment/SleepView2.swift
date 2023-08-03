//
//  SleepView2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/26/23.
//

import SwiftUI

struct SleepView2: View {
    @Binding var entries: [SleepEntry]
    @State private var isAddingNew = false
    @State private var newEntry = SleepEntry.newEntry
    
    var body: some View {
    
        
        
        NavigationStack{
            
            Form{
                Section(header: Text("Experiment Info")){
                    Text("Q: How much sleep should you get?")
                        .toolbar {
                        Button("New entry") {
                            entries.append(newEntry)
                            //immediately add a new entry and present a sleepeditview as a sheet to edit that entry
                            isAddingNew = true
                            
                        }
                    }
                    
                    NavigationLink(destination: SleepProcedureView()){
                        Text("Procedure")
                    }
                    NavigationLink(destination: Text("in development lol")){
                        Text("Results")
                    }
                    NavigationLink(destination: Text("Notes view")){
                        Text("Notes")
                    }
                }
                .navigationTitle(Text("Sleep Experiment"))
                
                
                Section(header: Text("Entries")) {
                    ForEach($entries) { entryBinding in
                        NavigationLink(destination: SleepEditView(entry:entryBinding).navigationTitle("Edit entry")) {
                            SimplifiedSleepView(entry: entryBinding)
                        }
                    }
                    .onDelete { indices in
                        deleteEntries(at: indices)
                    }
                }
                                
            }.sheet(isPresented: $isAddingNew) {
                
                NavigationStack {
                    SleepEditView(entry: $entries[entries.count-1])// return the last item in entries because when the button was pressed, an empty entry was added
                        .navigationTitle("New Entry")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isAddingNew = false
                                    entries.removeLast()
                                }
                            }
                        }
                }
            }

            
        }
    }
    private func deleteEntries(at indices: IndexSet) {
        entries.remove(atOffsets: indices)
    }
}


struct SleepView2_Previews: PreviewProvider {
    static var previews: some View {
        SleepView2(entries: .constant(SleepEntry.sampleData))
    }
}
