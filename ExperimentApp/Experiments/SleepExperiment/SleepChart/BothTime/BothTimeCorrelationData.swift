//
//  BothTimeCorrelationData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/24/23.
//

import SwiftUI

struct BothTimeCorrelationData: View {
    var experiment: SleepExperiment
    @State var chartToShow: ChartPicker.pickerValues = .bedtime
    var body: some View {
        if(experiment.entries.count>=14){
            if(experiment.dependentVariable == .both){
                //required: 14 entries
                ChartPicker(pickerValue: $chartToShow)
                //quality
                
                switch(chartToShow){
                case .bedtime:
                    NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleBedtimeBarChart(experiment: experiment, dependentVariable: .quality)
                    }
                case .waketime:
                    NavigationLink(destination: WaketimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleWaketimeBarChart(experiment: experiment, dependentVariable: .quality)
                    }
                case .sleeptime:
                    NavigationLink(destination: SleepTimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleSleepTimeBarChart(experiment: experiment, dependentVariable: .quality)
                    }
                }
                //productivity
                
                switch(chartToShow){
                case .bedtime:
                    NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleBedtimeBarChart(experiment: experiment, dependentVariable: .productivity)
                    }
                case .waketime:
                    NavigationLink(destination: WaketimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleWaketimeBarChart(experiment: experiment, dependentVariable: .productivity)
                    }
                case .sleeptime:
                    NavigationLink(destination: SleepTimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleSleepTimeBarChart(experiment: experiment, dependentVariable: .productivity)
                    }
                }
                
            } else{
                ChartPicker(pickerValue: $chartToShow)
                switch(chartToShow){
                case .bedtime:
                    NavigationLink(destination: BedtimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleBedtimeBarChart(experiment: experiment, dependentVariable: experiment.dependentVariable)
                    }
                case .waketime:
                    NavigationLink(destination: WaketimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleWaketimeBarChart(experiment: experiment, dependentVariable: experiment.dependentVariable)
                    }
                case .sleeptime:
                    NavigationLink(destination: SleepTimeScatterPlot(experiment: experiment, dependentVariable: experiment.dependentVariable)){
                        SimpleSleepTimeBarChart(experiment: experiment, dependentVariable: experiment.dependentVariable)
                    }
                }
                
            }
        }else {
            EntryProgressView(count: experiment.entries.count, needed: 14, text: "to view correlational data")
            ChartPicker(pickerValue: $chartToShow)
            switch(chartToShow){
            case .bedtime:
                WaketimeChartPreview(experiment: experiment)
            case .waketime:
                BedtimeChartPreview(experiment: experiment)
            case .sleeptime:
                SleepTimeChartPreview(experiment: experiment)
            }
            
            
        }
    }
}

struct BothTimeCorrelationData_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            BothTimeCorrelationData(experiment: SleepExperiment.bothTimesSampleExperiment)
        }
    }
}
