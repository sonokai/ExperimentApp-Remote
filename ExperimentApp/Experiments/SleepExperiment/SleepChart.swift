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
        @State var buttonValue: ButtonValue = .bedtime
        VStack{
            
            let dependent = experiment.dependentVariable
            switch(experiment.independentVariable){
            case .bedtime:
                
                Chart(experiment.entries){ entry in
                    if(dependent == .quality || dependent == .both){
                        PointMark(
                            x: .value("Bedtime", entry.bedtime.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)/3600),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    }
                    if(dependent == .productivity || dependent == .both){
                        PointMark(
                            x: .value("Bedtime", entry.bedtime.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)/3600),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                    
                }
                .chartXScale()
                .chartXAxis{
                    AxisMarks(
                        values: [0,6, 12, 18,24]
                    ) {
                        AxisValueLabel()
                    }
                }
            case .waketime:
                Chart(experiment.entries){ entry in
                    if(dependent == .quality || dependent == .both){
                        PointMark(
                            x: .value("Waketime", entry.waketime.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)/3600),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    }
                    if(dependent == .productivity || dependent == .both){
                        PointMark(
                            x: .value("Waketime", entry.waketime.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)/3600),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                    
                }
                .chartXScale()
                .chartXAxis{
                    AxisMarks(
                        values: [0,6, 12, 18,24]
                    ) {
                        AxisValueLabel()
                    }
                }
            case .both:
                Text("button for toggling")
                Picker("display", selection: $buttonValue){
                    Text("Bedtime").tag(ButtonValue.bedtime)
                    Text("Waketime").tag(ButtonValue.waketime)
                    Text("Total time slept").tag(ButtonValue.hoursSlept)
                }.pickerStyle(.segmented)
                
                switch(buttonValue){
                case .bedtime:
                    Text("display bedtime")
                case .waketime:
                    Text("display waketime")
                case .hoursSlept:
                    Text("display hours slept on x axis")
                }
            case .hoursSlept:
                Chart(experiment.entries){ entry in
                    if(dependent == .quality || dependent == .both){
                        PointMark(
                            x: .value("Hours Slept", entry.hoursSlept),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    }
                    if(dependent == .productivity || dependent == .both){
                        PointMark(
                            x: .value("Hours Slept", entry.hoursSlept),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                    
                }
                .chartXScale()
                .chartXAxis{
                    AxisMarks(
                        values: [0,6, 12]
                    ) {
                        AxisValueLabel()
                    }
                }
            }
            
            
            Spacer().frame(minHeight: 100)
            
        }
    }
}

struct SleepChart_Previews: PreviewProvider {
    static var previews: some View {
        SleepChart(experiment: SleepExperiment.sampleExperiment1)
    }
}
