//
//  SleepStats.swift
//  ExperimentApp
//
//  Created by Bell Chen on 10/19/23.
//

import SwiftUI

struct BedtimeResults: View {
    var experiment: SleepExperiment
    var body: some View {
        NavigationStack{
            Form{
                Section("Correlational data"){
                    if(experiment.entries.count>=14){
                        if(experiment.dependentVariable == .both){
                            //required: 14 entries
                            NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: .quality)){
                                SimpleBedtimeBarChart(experiment: experiment, dependentVariable: .quality)
                            }
                            NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: .productivity)){
                                SimpleBedtimeBarChart(experiment: experiment, dependentVariable: .productivity)
                            }
                        } else{
                            NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                                SimpleBedtimeBarChart(experiment: experiment, dependentVariable: experiment.dependentVariable)
                            }
                        }
                    }else {
                        EntryProgressView(count: experiment.entries.count, needed: 14, text: "to view correlational data")
                        BedtimeChartPreview(experiment: experiment)
                        
                    }
                }
                Section("Independent variable data"){
                    //required: 7 entries
                    if(experiment.entries.count>=7){
                        NavigationLink(destination: BedtimeHistory(experiment: experiment)){
                            SimpleBedtimeHistory(experiment: experiment)
                        }
                    } else{
                        EntryProgressView(count: experiment.entries.count, needed: 7, text: "to view bedtime data")
                    }
                }
                Section("Dependent variable data"){
                    //required: 1 entry
                    if(experiment.entries.count>=1){
                        if(experiment.dependentVariable == .both){
                            NavigationLink(destination: SleepDependentHistory(experiment: experiment, dependentVariable: .quality)){
                                SimpleSleepDependentHistory(experiment: experiment, dependentVariable: .quality)
                            }
                            NavigationLink(destination: SleepDependentHistory(experiment: experiment, dependentVariable: .productivity)){
                                SimpleSleepDependentHistory(experiment: experiment, dependentVariable: .productivity)
                            }
                        }else{
                            NavigationLink(destination: SleepDependentHistory(experiment: experiment)){
                                SimpleSleepDependentHistory(experiment: experiment)
                            }
                        }
                    } else{
                        EntryProgressView(count: experiment.entries.count, needed: 1, text: "to view dependent variable data")
                    }
                    
                    
                }
                
            }
        }.navigationTitle(Text("Experiment results"))
        
    }
    
}

struct SleepStats_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            BedtimeResults(experiment: SleepExperiment.midnightSampleExperiment)
        }
    }
}
