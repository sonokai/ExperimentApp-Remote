//
//  DayView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct DayView: View {
    @Binding var dayExperiment: DayExperiment
    
    
    @State private var isAddingNew = false
    
    
    var body: some View {
        var entries: [DayEntry] = dayExperiment.entries
        NavigationStack{
            Form{
                Section(header: Text("Experiment Info")){
                    Text("Q: What time of day should you work?")
                        .toolbar {
                            Button("New entry") {
                                entries.append(DayEntry.newEntry)
                                //immediately add a new entry and present an editview as a sheet to edit that entry
                                isAddingNew = true
                                
                            }
                        }
                    
                    NavigationLink(destination: DayProcedureView()){
                        Text("Procedure")
                    }
                    NavigationLink(destination: Text("in development lol")){
                        Text("Results")
                    }
                    
                    NavigationLink(destination: Text("Notes view")){
                        Text("Notes")
                    }
                }
                .navigationTitle(Text("Daily Productivity"))
                
                Section(header: Text("Entries")){
                    
                    ForEach($dayExperiment.entries) { entry in
                        
                        NavigationLink(destination: DayEditView(
                            entry:entry,
                            independentVariable: dayExperiment.independentVariable,
                            dependentVariable: dayExperiment.dependentVariable
                        )){
                            DayEntryView(entry:entry, dependentVariable: dayExperiment.dependentVariable)
                        }
                        
                    }
                    .onDelete { indices in
                        deleteEntries(at: indices)
                    }
                    
                }
            } //form ends
            .sheet(isPresented: $isAddingNew){
                NavigationStack{
                    DayEditView(entry:$dayExperiment.entries[entries.count-1], independentVariable: dayExperiment.independentVariable, dependentVariable: dayExperiment.dependentVariable )
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
        dayExperiment.entries.remove(atOffsets: indices)
    }
}
struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayExperiment: .constant(DayExperiment.sampleExperiment))
    }
}
