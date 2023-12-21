//
//  SleepTimeResults.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/6/23.
//

import SwiftUI
//this is sleep time results
struct SleepTimeResults: View {
    var experiment: SleepExperiment
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Correlational data"){
                    if(experiment.entries.count>=14){
                        if(experiment.dependentVariable == .both){
                            //required: 14 entries
                            NavigationLink(destination: SleepTimeScatterPlot(experiment: experiment, dependentVariable: .quality)){
                                SimpleSleepTimeBarChart(experiment: experiment, dependentVariable: .quality)
                            }
                            NavigationLink(destination: SleepTimeScatterPlot(experiment: experiment, dependentVariable: .productivity)){
                                SimpleSleepTimeBarChart(experiment: experiment, dependentVariable: .productivity)
                            }
                        } else{
                            NavigationLink(destination: SleepTimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                                SimpleSleepTimeBarChart(experiment: experiment, dependentVariable: experiment.dependentVariable)
                            }
                        }
                    }else {
                        EntryProgressView(count: experiment.entries.count, needed: 14, text: "to view correlational data")
                        SleepTimeChartPreview(experiment: experiment)
                        
                    }
                }
                Section("Independent variable data"){
                    //required: 7 entries
                    if(experiment.entries.count>=7){
                        NavigationLink(destination: SleepTimeHistory(experiment: experiment)){
                            SimpleSleepTimeHistory(experiment: experiment)
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

struct SleepTimeResults_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeResults(experiment: SleepExperiment.hoursSleptSampleExperiment)
    }
}
