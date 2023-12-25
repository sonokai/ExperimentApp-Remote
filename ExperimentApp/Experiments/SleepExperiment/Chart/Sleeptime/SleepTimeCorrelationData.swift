//
//  SleepTimeCorrelationData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/24/23.
//

import SwiftUI

struct SleepTimeCorrelationData: View {
    var experiment: SleepExperiment
    var body: some View {
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
}

struct SleepTimeCorrelationData_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            SleepTimeCorrelationData(experiment: SleepExperiment.hoursSleptSampleExperiment)
        }
    }
}
