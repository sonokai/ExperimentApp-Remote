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
    var interval: Date
    var size: Int
    var showRange: Bool = false
    @Binding var dependentVariable: SleepExperiment.DependentVariable
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
                }.onChange(of: picker){ newValue in
                    if(newValue == .quality){
                        dependentVariable = .quality
                    }
                    if(newValue == .productivity){
                        dependentVariable = .productivity
                    }
                }
            }
            Chart(){
                if(showRange){
                    RectangleMark(
                        xStart: .value("Start of interval", convertDate(from: interval)),
                        xEnd: .value("End of best interval", addMinutesToDate(date: interval, minutesToAdd: size)),
                        yStart: nil,
                        yEnd: nil
                    ).foregroundStyle(.green)
                }
                ForEach(experiment.entries){ entry in
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
        dateFormatter.dateFormat = "H:mm"
        let formattedTime = dateFormatter.string(from: date)
        return formattedTime
    }
    func convertDate(from date: Date) -> Date{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:mm a"
        let dateString = dateformatter.string(from: date)
        let newDate = dateformatter.date(from: dateString)
        return newDate!
        
    }
    func addMinutesToDate(date: Date, minutesToAdd: Int) -> Date {
        let calendar = Calendar.current
        let updatedDate = calendar.date(byAdding: .minute, value: minutesToAdd, to: date)
        return convertDate(from: updatedDate!)
        
    }
}

struct SleepTimeChart_Previews: PreviewProvider {
    static let testInterval: Date = Calendar.current.date(bySettingHour: 10, minute: 50, second: 0, of: Date())!
    static var previews: some View {
        SleepTimeChart(experiment: SleepExperiment.hoursSleptSampleExperiment, interval: testInterval, size: 15, showRange: true, dependentVariable: .constant(.both))
    }
}
