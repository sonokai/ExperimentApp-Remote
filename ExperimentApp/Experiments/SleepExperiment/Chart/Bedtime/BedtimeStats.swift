//
//  SleepStats.swift
//  ExperimentApp
//
//  Created by Bell Chen on 10/19/23.
//

import SwiftUI

struct BedtimeStats: View {
    var experiment: SleepExperiment
    var body: some View {
        NavigationStack{
            Form{
                Section("Correlational data"){
                    if(experiment.dependentVariable == .both){
                        NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: .quality)){
                            SimpleBedtimeBarChart(experiment: experiment, dependentVariable: .quality)
                        }
                        NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: .productivity)){
                            SimpleBedtimeBarChart(experiment: experiment, dependentVariable: .productivity)
                        }
                    } else{
                        NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                            SimpleBedtimeChart(experiment: experiment, dependentVariable: experiment.dependentVariable)
                        }
                    }
                }
                Section("Independent variable data"){
                    NavigationLink(destination: BedtimeHistory(experiment: experiment)){
                        SimpleBedtimeHistory(experiment: experiment)
                    }
                }
                Section("Dependent variable data"){
                    /*
                    if(dependentVariable == .quality){
                        HStack{
                            Text("Average quality of day: ")
                            Spacer()
                            Text("\(experiment.getAverageQuality())")
                        }
                    } else{
                        HStack{
                            Text("Average productivity: ")
                            Spacer()
                            Text("\(experiment.getAverageProductivity())")
                        }
                    }
                     */
                }
                
            }
        }.navigationTitle(Text("Results"))
        
    }
    
}

struct SleepStats_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            BedtimeStats(experiment: SleepExperiment.midnightSampleExperiment)
        }
    }
}
