//
//  SimpleBedtimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI
import Charts

struct BedtimeChartPreview: View {
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
                            x: .value("Bedtime", entry.bedtime.formatDateForChart()),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    }
                    if(experiment.dependentVariable == .productivity || experiment.dependentVariable == .both){
                        PointMark(
                            x: .value("Bedtime", entry.bedtime.formatDateForChart()),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                }
            }.frame(height: 250)
                .chartXAxisLabel("Bedtime")
                .chartYAxisLabel("Productivity")
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
}

struct SimpleBedtimeChart_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeChartPreview(experiment: SleepExperiment.midnightSampleExperiment)
    }
}
