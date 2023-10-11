//
//  WaketimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts
//hey does this work
struct WaketimeChart: View {
    var entries: [SleepEntry]
    var dependent: SleepExperiment.DependentVariable
    var body: some View {
        VStack{
            Text("this is a title yay")
            Chart(entries){ entry in
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
            .chartYAxisLabel(getYAxisLabel())
            .chartXAxisLabel("Waketime")
            .chartForegroundStyleScale(legendStyle())
            .chartXAxis{
                AxisMarks(
                    values: [0,6, 12, 18,24]
                ) {
                    AxisValueLabel()
                }
            }
            Spacer().frame(minHeight:100)
        }
        .padding()
    }
    
    private func getYAxisLabel() -> String{
        switch(dependent){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both: return ""
        }
    }
    private func legendStyle() -> KeyValuePairs<String, Color> {
        if (dependent == .both) {
            return [
                "Productivity": .blue, "Quality": .red
            ]
        } else {
            return [:] // Empty KeyValuePairs if the condition is not met
        }
    }
}

struct WaketimeChart_Previews: PreviewProvider {
    static var previews: some View {
        WaketimeChart(entries: SleepExperiment.sampleDataForExperiment2, dependent: .both)
    }
}
