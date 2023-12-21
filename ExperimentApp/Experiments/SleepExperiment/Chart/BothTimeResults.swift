//
//  BothTimeResults.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI

struct BothTimeResults: View {
    var experiment: SleepExperiment
    @State var chartToShow: ChartPicker.pickerValues = .bedtime
    var body: some View {
        NavigationStack{
            Form{
                Section("Correlational data"){
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
                Section("Independent variable data"){
                    //required: 7 entries
                    if(experiment.entries.count>=7){
                        NavigationLink(destination: BedtimeHistory(experiment: experiment)){
                            SimpleBedtimeHistory(experiment: experiment)
                        }
                        NavigationLink(destination: WakeTimeHistory(experiment: experiment)){
                            SimpleWaketimeHistory(experiment: experiment)
                        }
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

struct BothTimeResults_Previews: PreviewProvider {
    static var previews: some View {
        BothTimeResults(experiment: SleepExperiment.bothTimesSampleExperiment)
    }
}
