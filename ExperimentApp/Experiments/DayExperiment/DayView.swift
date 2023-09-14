//
//  DayView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct DayView: View {
    @Binding var experiment: DayExperiment
    
    
    @State private var isAddingNew = false
    
    
    var body: some View {
        var entries: [DayEntry] = experiment.entries
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
                    NavigationLink(destination: DayChart(experiment: experiment)){
                        Text("Results")
                    }
                    
                    NavigationLink(destination: Text("Notes view")){
                        Text("Notes")
                    }
                }
                .navigationTitle(Text("Daily Productivity"))
                
                Section(header: Text("Entries")){
                    
                    ForEach($experiment.entries) { entry in
                        
                        NavigationLink(destination: DayEditView(
                            entry:entry,
                            independentVariable: experiment.independentVariable,
                            dependentVariable: experiment.dependentVariable
                        )){
                            DayEntryView(entry:entry, dependentVariable: experiment.dependentVariable)
                        }
                        
                    }
                    .onDelete { indices in
                        deleteEntries(at: indices)
                    }
                    
                }
            } //form ends
            .sheet(isPresented: $isAddingNew){
                NavigationStack{
                    DayEditView(entry:$experiment.entries[entries.count-1], independentVariable: experiment.independentVariable, dependentVariable: experiment.dependentVariable )
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
        experiment.entries.remove(atOffsets: indices)
    }
}
struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(experiment: .constant(DayExperiment.sampleExperiment))
    }
}
