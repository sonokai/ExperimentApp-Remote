//
//  SleepView3.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
// a version of sleep experiment that can customize name, notes, type of variables upon config 


import SwiftUI

struct SleepView: View {
    @Binding var experiment: SleepExperiment
    @State var showInsights: Bool = true
    @State var showCorrelationalData: Bool = true
    @State var showIndependentVariableData: Bool = true
    @State var showDependentVariableData: Bool = true
    
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: SleepExperimentHeader(title: "Insights", isOn: $showInsights)){
                    if(showInsights){
                        SleepInsightView(experiment: $experiment)
                    }
                }
                //results
                switch(experiment.independentVariable){
                case .bedtime:
                    Section(header: SleepExperimentHeader(title: "Correlational Data", isOn: $showCorrelationalData)){
                        if(showCorrelationalData){
                            BedtimeCorrelationData(experiment: experiment)
                        }
                    }
                    
                    Section(header: SleepExperimentHeader(title: "Bedtime data", isOn: $showIndependentVariableData)){
                        if(showIndependentVariableData){
                            BedtimeData(experiment: experiment)
                        }
                    }
                case .waketime:
                    Section(header: SleepExperimentHeader(title: "Correlational Data", isOn: $showCorrelationalData)){
                        if(showCorrelationalData){
                            WaketimeCorrelationData(experiment: experiment)
                        }
                    }
                    
                    Section(header: SleepExperimentHeader(title: "Wake time data", isOn: $showIndependentVariableData)){
                        if(showIndependentVariableData){
                            WaketimeData(experiment: experiment)
                        }
                    }
                case .both:
                    Section(header: SleepExperimentHeader(title: "Correlational Data", isOn: $showCorrelationalData)){
                        if(showCorrelationalData){
                            BothTimeCorrelationData(experiment: experiment)
                        }
                    }
                    
                    Section(header: SleepExperimentHeader(title: "Independent variable data", isOn: $showIndependentVariableData)){
                        if(showIndependentVariableData){
                            BothTimeData(experiment: experiment)
                        }
                    }
                case .hoursSlept:
                    Section(header: SleepExperimentHeader(title: "Correlational Data", isOn: $showCorrelationalData)){
                        if(showCorrelationalData){
                            SleepTimeCorrelationData(experiment: experiment)
                        }
                    }
                    Section(header: SleepExperimentHeader(title: "Sleep time data", isOn: $showIndependentVariableData)){
                        if(showIndependentVariableData){
                            SleepTimeData(experiment: experiment)
                        }
                    }
                }
                Section(header: SleepExperimentHeader(title: "Dependent variable data", isOn: $showDependentVariableData)){
                    if(showDependentVariableData){
                        DependentVariableData(experiment: experiment)
                    }
                }
            }
            .navigationTitle(Text("\(experiment.name)"))
            .toolbar(content: toolbarContent)

        }
    }
    
}


struct SleepView3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SleepView(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))
        }
    }
}
