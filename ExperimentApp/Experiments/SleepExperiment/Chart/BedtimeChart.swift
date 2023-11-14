//
//  BedtimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts

struct BedtimeChart: View {
    var experiment: SleepExperiment
    @State var pickerValue: ChartPicker.pickerValues = .none
    var interval: Date
    var size: Int
    var showRange: Bool = false
    @Binding var dependentVariable: SleepExperiment.DependentVariable
    var body: some View {
        VStack(alignment:.leading){
            ChartPicker(experiment: experiment, pickerValue: $pickerValue, dependentVariable: $dependentVariable)
            Text(experiment.getChartTitle(buttonValue: pickerValue.rawValue, independentVariable: .bedtime))
            
            Chart(){
                if(showRange){
                    RectangleMark(
                        xStart: .value("Start of interval", interval.formatDateForChart()),
                        xEnd: .value("End of best interval", interval.addMinutesToDate(minutesToAdd: size)),
                        yStart: nil,
                        yEnd: nil
                    ).foregroundStyle(.green)
                }
                
                ForEach(experiment.entries){ entry in
                    if(experiment.dependentVariable == .quality || pickerValue == .quality || pickerValue == .compare ){
                        PointMark(
                            x: .value("Bedtime", entry.bedtime.formatDateForChart()),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    }
                    if(experiment.dependentVariable == .productivity || pickerValue == .productivity || pickerValue == .compare){
                        PointMark(
                            x: .value("Bedtime", entry.bedtime.formatDateForChart()),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                }
                
                
            }
            
            .chartXScale()
            .chartYAxisLabel(getYAxisLabel())
            .chartXAxisLabel("Bedtime")
            .chartForegroundStyleScale(legendStyle())
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
            .frame(height:300)
            Spacer()
        }
        .padding()
        
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

struct BedtimeChart_Previews: PreviewProvider {
    static let testInterval: Date = Calendar.current.date(bySettingHour: 10, minute: 50, second: 0, of: Date())!
    static var previews: some View {
        BedtimeChart(experiment: SleepExperiment.midnightSampleExperiment, interval: testInterval, size: 15, dependentVariable: .constant(.quality))
    }
}
