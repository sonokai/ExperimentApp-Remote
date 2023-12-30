//
//  SleepHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI

struct SleepHistory: View {
    @Binding var experiment: SleepExperiment
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Entries")) {
                    ForEach($experiment.entries.reversed()) { entryBinding in
                        NavigationLink(destination: SleepEditView(entry:entryBinding, experiment: $experiment).navigationTitle("Edit entry")) {
                            SimplifiedSleepView(sleepExperiment: experiment, entry: entryBinding)
                        }
                    }
                    .onDelete { indexSet in
                        let originalIndices = indexSet.map { index in
                            experiment.entries.count - 1 - index
                        }
                        deleteEntries(at: IndexSet(originalIndices))
                    }
                }
            }
        }.navigationTitle(Text("History"))
    }
    private func deleteEntries(at indices: IndexSet) {
        experiment.entries.remove(atOffsets: indices)
    }
}

struct SleepHistory_Previews: PreviewProvider {
    static var previews: some View {
        SleepHistory(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))
    }
}
