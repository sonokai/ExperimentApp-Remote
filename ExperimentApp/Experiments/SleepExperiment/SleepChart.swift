//
//  SleepChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/15/23.
//

import SwiftUI
import Charts
struct SleepChart: View {
    var experiment: SleepExperiment
    @State var buttonValue: ButtonValue = .bedtime
    //for both bedtime and waketime, create a button that switches the charts, for bedtime, waketime, and total time slept
    enum ButtonValue: String{
        case bedtime = "Bedtime"
        case waketime = "WakeTime"
        case hoursSlept = "Hours Slept"
    }
    // for independent variable hours slept, just do normal display
    var body: some View {
        //if dependent var =  productivity or both display productivity chart
        
        // if dependent var = quality or both display quality chart
        //actually scratch that lets just make both display on the same chart
        
        VStack{
            switch(experiment.independentVariable){
            case .bedtime:
                
                BedtimeChart(entries: experiment.entries, dependent: experiment.dependentVariable)
            case .waketime:
                WaketimeChart(entries: experiment.entries, dependent: experiment.dependentVariable)
            case .both:
                Text("this is a button for toggling")
                Picker("display", selection: $buttonValue){
                    Text("Bedtime").tag(ButtonValue.bedtime)
                    Text("Waketime").tag(ButtonValue.waketime)
                    Text("Total time slept").tag(ButtonValue.hoursSlept)
                }.pickerStyle(.segmented)
                
                switch(buttonValue){
                case .bedtime:
                    Text("display bedtime here")
                    BedtimeChart(entries: experiment.entries, dependent: experiment.dependentVariable)
                case .waketime:
                    Text("display waketime")
                    WaketimeChart(entries: experiment.entries, dependent: experiment.dependentVariable)
                case .hoursSlept:
                    Text("display hours slept on x axis")
                }
            case .hoursSlept:
                SleepTimeChart(entries: experiment.entries, dependent: experiment.dependentVariable)
            }
            
            
            
            
        }
    }
}

struct SleepChart_Previews: PreviewProvider {
    static var previews: some View {
        SleepChart(experiment: SleepExperiment.sampleExperiment2)
    }
}
