//
//  SleepTimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts
struct SleepTimeChart: View {
    @State var picker: pickerValues = .none
    enum pickerValues : String{
        case none = ""
        case quality = "Quality"
        case productivity = "Productivity"
        case compare = "Compare"
    }
    var experiment: SleepExperiment
    var body: some View {
        VStack(alignment: .leading){
            Text(experiment.getTitle())
            if(experiment.dependentVariable == .both){
                Picker("Chart Y axis",selection: $picker){
                    Text("Quality").tag(pickerValues.quality)
                    Text("Productivity").tag(pickerValues.productivity)
                    Text("Compare").tag(pickerValues.compare)
                }
                .pickerStyle(.segmented)
                .onAppear(){
                    picker = .quality
                }
            }
            Chart(experiment.entries){ entry in
                if(experiment.dependentVariable == .quality || picker == .quality || picker == .compare){
                    PointMark(
                        x: .value("Hours Slept", formatTime(hour:entry.hoursSlept, minute: entry.minutesSlept)),
                        y: .value("Quality", entry.quality)
                    ).foregroundStyle(.red)
                }
                if(experiment.dependentVariable == .productivity || picker == .productivity || picker == .compare){
                    PointMark(
                        x: .value("Hours Slept", formatTime(hour:entry.hoursSlept, minute: entry.minutesSlept)),
                        y: .value("Productivity", entry.productivity)
                    ).foregroundStyle(.blue)
                }
                
            }
            .chartXScale()
            .chartXAxisLabel("Hours slept")
            .frame(height: 300)
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
            
            
            
            Spacer()
        }
        .padding()
    }
    
    func convertDate(hour: Int, minute: Int) -> Date?{
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        return Calendar.current.date(from: dateComponents)
        
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
    func timeString(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: date)
        return formattedTime
    }
}

struct SleepTimeChart_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeChart(experiment: SleepExperiment.hoursSleptSampleExperiment)
    }
}
