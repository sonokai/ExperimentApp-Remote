//
//  NewSleepInsightView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

struct NewSleepInsightView: View {
    @Binding var experiment: SleepExperiment
    @State var text: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality
    
    @State var showBedtime: Bool = true
    @State var showWaketime: Bool = true
    @State var showSleeptime: Bool = true
    var body: some View {
        NavigationStack{
            Form{
                Section("Write your new insight here"){
                    TextEditor(text: $text).frame(minHeight: 100)
                }
                if(experiment.independentVariable == .bedtime || experiment.independentVariable == .both){
                    Section(header: SleepExperimentHeader(title: "Bedtime insights", isOn: $showBedtime)){
                        if(showBedtime){
                            BedtimeInsights(experiment: experiment, text: $text)
                        }
                    }
                }
                if(experiment.independentVariable == .waketime || experiment.independentVariable == .both){
                    Section(header: SleepExperimentHeader(title: "Waketime insights", isOn: $showWaketime)){
                        if(showWaketime){
                            WaketimeInsights(experiment: experiment, text: $text)
                        }
                    }
                }
                if(experiment.independentVariable == .hoursSlept || experiment.independentVariable == .both){
                    Section(header: SleepExperimentHeader(title: "Sleep time insights", isOn: $showSleeptime)){
                        if(showSleeptime){
                            SleepTimeInsights(experiment: experiment, text: $text)
                        }
                    }
                }
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Done"){
                        experiment.insights.append(Insight(text: text, date: Date()))
                        presentationMode.wrappedValue.dismiss()
                    }.disabled(text == "")
                }
            }.navigationTitle("New insight")
                .buttonStyle(.borderless)
        }
    }
    
}

struct BedtimeInsights: View{
    var experiment: SleepExperiment
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality
    @State var bedtimeInsights: [BedtimeBarChartEntry] = []
    @Binding var text: String
    @State var show: Bool = true
    var body: some View{
        if(show){
            Text("Loading...").onAppear(){
                if(experiment.dependentVariable != .both){
                    dependentVariable = experiment.dependentVariable
                }
                updateBedtimeInsights()
                show = false
            }
        }
        if(experiment.dependentVariable == .both){
            Picker("Chart Y axis",selection: $dependentVariable){
                Text("Quality").tag(SleepExperiment.DependentVariable.quality)
                Text("Productivity").tag(SleepExperiment.DependentVariable.productivity)
            }
            .pickerStyle(.segmented)
            .onChange(of: dependentVariable){ _ in
                updateBedtimeInsights()
            }
        }
        ForEach(bedtimeInsights) { insight in
            HStack{
                let insightString = "When I went to bed from \(insight.time), my average \(dependentVariable.nameInSentence) was \(BedtimeInsights.formatDouble(insight.value)) (\(experiment.compareAverage(insight.value, dependentVariable)))."
                Text(insightString)
                Spacer()
                Button("Add"){
                    text = insightString
                }
            }
        }
    }
    func updateBedtimeInsights(){
        bedtimeInsights = []
        for minutes in stride(from: 720, through: 2160, by: 30){
            if(experiment.entryCountInBedtimeInterval(at: minutes, for: 30) >= 2){
                bedtimeInsights.append(BedtimeBarChartEntry(experiment: experiment, dependentVariable: dependentVariable, time: minutes))
            }
        }
    }
    static func formatDouble(_ double: Double)-> String{
        let string = double.formatted()
        if(string.count > 5){
            return String(string.prefix(5))
        }
        return string
    }
}
struct WaketimeInsights: View{
    var experiment: SleepExperiment
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality
    @State var waketimeInsights: [WaketimeBarChartEntry] = []
    @Binding var text: String
    @State var show: Bool = true
    var body: some View{
        if(show){
            Text("Loading...").onAppear(){
                if(experiment.dependentVariable != .both){
                    dependentVariable = experiment.dependentVariable
                }
                updateWaketimeInsights()
                show = false
            }
        }
        if(experiment.dependentVariable == .both){
            Picker("Chart Y axis",selection: $dependentVariable){
                Text("Quality").tag(SleepExperiment.DependentVariable.quality)
                Text("Productivity").tag(SleepExperiment.DependentVariable.productivity)
            }
            .pickerStyle(.segmented)
            .onChange(of: dependentVariable){ _ in
                updateWaketimeInsights()
            }
        }
        ForEach(waketimeInsights) { insight in
            HStack{
                let insightString = "When I woke up from \(insight.time), my average \(dependentVariable.nameInSentence) was \(BedtimeInsights.formatDouble(insight.value)) (\(experiment.compareAverage(insight.value, dependentVariable)))."
                Text(insightString)
                Spacer()
                Button("Add"){
                    text = insightString
                }
            }
        }
    }
    func updateWaketimeInsights(){
        waketimeInsights = []
        for minutes in stride(from: 0, through: 1440, by: 30){
            if(experiment.entryCountInWaketimeInterval(at: minutes, for: 30) >= 2){
                waketimeInsights.append(WaketimeBarChartEntry(experiment: experiment, dependentVariable: dependentVariable, time: minutes))
            }
        }
    }
    
}
struct SleepTimeInsights: View{
    var experiment: SleepExperiment
    @State var dependentVariable: SleepExperiment.DependentVariable = .quality
    @State var sleepTimeInsights: [SleepTimeBarChartEntry] = []
    @Binding var text: String
    @State var show: Bool = true
    var body: some View{
        if(show){
            Text("Loading...").onAppear(){
                if(experiment.dependentVariable != .both){
                    dependentVariable = experiment.dependentVariable
                }
                updateSleeptimeInsights()
                show = false
            }
        }
        if(experiment.dependentVariable == .both){
            Picker("Chart Y axis",selection: $dependentVariable){
                Text("Quality").tag(SleepExperiment.DependentVariable.quality)
                Text("Productivity").tag(SleepExperiment.DependentVariable.productivity)
            }
            .pickerStyle(.segmented)
            .onChange(of: dependentVariable){ _ in
                updateSleeptimeInsights()
            }
        }
        ForEach(sleepTimeInsights) { insight in
            HStack{
                let insightString = "When I slept for a total of \(insight.time), my average \(dependentVariable.nameInSentence) was \(BedtimeInsights.formatDouble(insight.value)) (\(experiment.compareAverage(insight.value, dependentVariable)))."
                Text(insightString)
                Spacer()
                Button("Add"){
                    text = insightString
                }
            }
        }
    }
    func updateSleeptimeInsights(){
        sleepTimeInsights = []
        for minutes in stride(from: 0, through: 1440, by: 30){
            if(experiment.entryCountInSleepTimeInterval(at: minutes, for: 30) >= 2){
                sleepTimeInsights.append(SleepTimeBarChartEntry(experiment: experiment, dependentVariable: dependentVariable, time: minutes))
            }
        }
    }
}
struct NewSleepInsightView_Previews: PreviewProvider {
    static var previews: some View {
        NewSleepInsightView(experiment: .constant(SleepExperiment.bedtimeSampleExperiment))
    }
}
