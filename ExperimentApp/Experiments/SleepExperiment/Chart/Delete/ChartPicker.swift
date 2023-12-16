
//
//  ChartPicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/13/23.
//

import SwiftUI

struct ChartPicker: View {
    var experiment: SleepExperiment
    @Binding var pickerValue: pickerValues
    @Binding var dependentVariable: SleepExperiment.DependentVariable
    enum pickerValues : String{
        case none = ""
        case quality = "quality"
        case productivity = "productivity"
        case compare = "compare"
    }
    var body: some View {
        if(experiment.dependentVariable == .both){
            Picker("Chart Y axis",selection: $pickerValue){
                Text("Quality").tag(pickerValues.quality)
                Text("Productivity").tag(pickerValues.productivity)
                Text("Compare").tag(pickerValues.compare)
            }
            .pickerStyle(.segmented)
            .onAppear(){
                pickerValue = .quality
            }
            .onChange(of: pickerValue){ newValue in
                if(newValue == .quality){
                    dependentVariable = .quality
                }
                if(newValue == .productivity){
                    dependentVariable = .productivity
                }
            }
        }

    }
}

struct ChartPicker_Previews: PreviewProvider {
    static var previews: some View {
        ChartPicker(experiment: SleepExperiment.bothTimesSampleExperiment, pickerValue: .constant(.quality), dependentVariable: .constant(.both))
    }
}
