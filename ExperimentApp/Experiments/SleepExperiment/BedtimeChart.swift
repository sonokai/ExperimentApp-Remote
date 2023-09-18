//
//  BedtimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts

struct BedtimeChart: View {
    var entries: [SleepEntry]
    var dependent: SleepExperiment.DependentVariable
    
    var body: some View {
        VStack{
            Chart(entries){ entry in
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
            .chartYAxisLabel(getYAxisLabel())
            .chartXAxisLabel("Bedtime")
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
    private func legendStyle() -> KeyValuePairs<String, Color> {
        if (dependent == .both) {
            return [
                "Productivity": .blue, "Quality": .red
            ]
        } else {
            return [:] // Empty KeyValuePairs if the condition is not met
        }
    }
    private func getYAxisLabel() -> String{
        switch(dependent){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both: return ""
        }
    }
}

struct BedtimeChart_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeChart(entries: SleepEntry.sampleData, dependent: .quality)
    }
}
