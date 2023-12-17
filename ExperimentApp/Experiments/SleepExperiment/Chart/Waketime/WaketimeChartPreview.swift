//
//  WaketimeChartPreview.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct WaketimeChartPreview: View {
    var experiment: SleepExperiment
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "bed.double")
                Text("Here is a preview of your results:")
            }.padding(.vertical)
            Chart(){
                ForEach(experiment.entries){ entry in
                    if(experiment.dependentVariable == .quality || experiment.dependentVariable == .both){
                        PointMark(
                            x: .value("Waketime", entry.waketime.formatDateForChart()),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    }
                    if(experiment.dependentVariable == .productivity || experiment.dependentVariable == .both){
                        PointMark(
                            x: .value("Waketime", entry.waketime.formatDateForChart()),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                }
            }.frame(height: 250)
                .chartXAxisLabel("Waketime")
                .chartYAxisLabel(getYAxisLabel())
                .chartXAxis {
                    AxisMarks() { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel {
                                VStack(alignment: .leading) {
                                    Text(date.simplifyDateToTimeString())
                                }
                            }
                            AxisGridLine()
                            AxisTick()
                        }
                    }
                }
                .chartForegroundStyleScale(legendStyle())
                
        }
    }
    private func legendStyle() -> KeyValuePairs<String, Color> {
        if (experiment.dependentVariable == .both) {
            return [
                "Productivity": .blue, "Quality": .red
            ]
        } else {
            return [:] // Empty KeyValuePairs if the condition is not met
        }
    }
    private func getYAxisLabel() -> String{
        switch(experiment.dependentVariable){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both: return ""
        }
    }
    
}

struct WaketimeChartPreview_Previews: PreviewProvider {
    static var previews: some View {
        WaketimeChartPreview(experiment: SleepExperiment.waketimeSampleExperiment)
    }
}
