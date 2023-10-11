//
//  SleepTimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts
struct SleepTimeChart: View {
    var entries: [SleepEntry]
    var dependent: SleepExperiment.DependentVariable
    var body: some View {
        VStack{
            Text("Title")
            Chart(entries){ entry in
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
            .chartXAxisLabel("Hours slept")
            .chartXAxis{
                AxisMarks(
                    values: [0,6, 12]
                ) {
                    AxisValueLabel()
                }
            }
            Spacer().frame(minHeight:100)
        }
        .padding()
    }
    
    
}

struct SleepTimeChart_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeChart(entries: SleepExperiment.sampleDataForExperiment3, dependent: .quality)
    }
}
