//
//  BedtimeCorrelationData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/23/23.
//

import SwiftUI

struct BedtimeCorrelationData: View {
    var experiment: SleepExperiment
    var body: some View {
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
}

struct BedtimeCorrelationData_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Form{
                Section("Data"){
                    BedtimeCorrelationData(experiment: SleepExperiment.bedtimeSampleExperiment)
                }
            }
        }
    }
}
