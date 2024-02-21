//
//  WaketimeCorrelationData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/23/23.
//

import SwiftUI

struct WaketimeCorrelationData: View {
    var experiment: SleepExperiment
    var body: some View {
        if(experiment.entries.count>=14){
            if(experiment.dependentVariable == .both){
                //required: 14 entries
                NavigationLink(destination: WaketimeScatterPlot(experiment: experiment, dependentVariable: .quality)){
                    SimpleWaketimeBarChart(experiment: experiment, dependentVariable: .quality)
                }
                NavigationLink(destination: WaketimeScatterPlot(experiment: experiment, dependentVariable: .productivity)){
                    SimpleWaketimeBarChart(experiment: experiment, dependentVariable: .productivity)
                }
            } else{
                NavigationLink(destination: WaketimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                    SimpleWaketimeBarChart(experiment: experiment, dependentVariable: experiment.dependentVariable)
                }
            }
        }else {
            EntryProgressView(count: experiment.entries.count, needed: 14, text: "to view correlational data")
            /*
            if(experiment.entries.count>1){
                WaketimeChartPreview(experiment: experiment)
            }
             */
            
        }
    }
}

struct WaketimeCorrelationData_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            WaketimeCorrelationData(experiment: SleepExperiment.waketimeSampleExperiment)
        }
    }
}
