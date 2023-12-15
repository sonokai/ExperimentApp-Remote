//
//  SimpleBedtimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI
import Charts

struct SimpleBedtimeChart: View {
    var experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable = .both
    var body: some View {
        VStack(alignment: .leading ){
            HStack{
                Image(systemName: "bed.double")
                Spacer()
                if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                    Text("Sleeping between ") + Text("9:30 PM").bold() + Text(" and ") + Text("10:00 PM").bold() +   Text(" maximizes your quality of day")
                }
                if(experiment.dependentVariable == .productivity || dependentVariable == .productivity){
                    Text("Sleeping between ") + Text("9:15 PM").bold() + Text(" and ") + Text("9:45 PM").bold() +   Text(" maximizes your productivity")
                }
            }
            Chart(){
                ForEach(experiment.entries){ entry in
                    if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                        PointMark(
                            x: .value("Bedtime", entry.bedtime.formatDateForChart()),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    } else if(experiment.dependentVariable == .productivity || dependentVariable == .productivity){
                        PointMark(
                            x: .value("Bedtime", entry.bedtime.formatDateForChart()),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                }
            }.frame(height: 100)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
        }
    }
}

struct SimpleBedtimeChart_Previews: PreviewProvider {
    static var previews: some View {
        SimpleBedtimeChart(experiment: SleepExperiment.bedtimeSampleExperiment, dependentVariable: .quality)
    }
}
