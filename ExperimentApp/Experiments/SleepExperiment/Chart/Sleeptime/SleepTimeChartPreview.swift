//
//  SleepTimeChartPreview.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct SleepTimeChartPreview: View {
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
                            x: .value("Time slept", formatTime(hour:entry.hoursSlept, minute: entry.minutesSlept)),
                            y: .value("Quality", entry.quality)
                        ).foregroundStyle(.red)
                    }
                    if(experiment.dependentVariable == .productivity || experiment.dependentVariable == .both){
                        PointMark(
                            x: .value("Time slept", formatTime(hour:entry.hoursSlept, minute: entry.minutesSlept)),
                            y: .value("Productivity", entry.productivity)
                        ).foregroundStyle(.blue)
                    }
                }
            }
            .chartXScale()
            .chartXAxisLabel("Hours slept")
            .frame(height: 250)
            .chartXAxis {
                AxisMarks(values: .stride(by: .minute, count: experiment.getAppropriateLengthOfChartAxisMarks())) { value in
                    if let date = value.as(Date.self) {
                        let hour = Calendar.current.component(.hour, from: date)
                        AxisValueLabel {
                            VStack(alignment: .leading) {
                                Text(timeString(date: date))
                            }
                        }
                        if hour == 0 {
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            AxisTick(stroke: StrokeStyle(lineWidth: 0.5))
                        } else {
                            AxisGridLine()
                            AxisTick()
                        }
                    }
                }
            }
            .chartYAxisLabel(getYAxisLabel())
            .chartForegroundStyleScale(legendStyle())
            
        }
        
    }
    func formatTime(hour: Int, minute: Int) -> Date {
        if let date = convertDate(hour: hour, minute: minute) {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH:mm"
            let dateString = dateformatter.string(from: date)
            let newDate = dateformatter.date(from: dateString)

            return newDate!
        } else {
            print("Uh oh")
            return Date()
        }
    }
    func convertDate(hour: Int, minute: Int) -> Date?{
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        return Calendar.current.date(from: dateComponents)
    }
    func timeString(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "H:mm"
        let formattedTime = dateFormatter.string(from: date)
        return formattedTime
    }
    private func getYAxisLabel() -> String{
        switch(experiment.dependentVariable){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both: return ""
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

struct SleepTimeChartPreview_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeChartPreview(experiment: SleepExperiment.hoursSleptSampleExperiment)
    }
}
