//
//  SleepTimeScatterPlot.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct SleepTimeScatterPlot: View {
    var experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable
    @State var interval: Date = Date()
    @State var size: Int = 30
    @State var showRange: Bool = false
    var body: some View {
        NavigationStack{
            Form{
                Section("Chart"){
                    VStack(alignment:.leading){
                        
                        Text(SleepExperiment.getChartTitle2(independentVariable: .hoursSlept, dependentVariable: dependentVariable)).font(.headline)
                        
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
                                if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                                    PointMark(
                                        x: .value("Time slept", formatTime(hour:entry.hoursSlept, minute: entry.minutesSlept)),
                                        y: .value("Quality", entry.quality)
                                    ).foregroundStyle(.red)
                                }
                                if(experiment.dependentVariable == .productivity || dependentVariable == .productivity){
                                    PointMark(
                                        x: .value("Time slept", formatTime(hour:entry.hoursSlept, minute: entry.minutesSlept)),
                                        y: .value("Productivity", entry.productivity)
                                    ).foregroundStyle(.blue)
                                }
                            }
                        }
                        .chartXScale()
                        .chartYAxisLabel(getYAxisLabel())
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
                        
                    }
                    .padding()
                }
                Section(header: SleepTimeStatsHeader()){
                    Toggle("Show optimal interval", isOn: $showRange)
                    
                    HStack{
                        Text("Optimal interval:")
                        Spacer()
                        Text("\(interval.simplifyDateToHMM()) - \(interval.addMinutesToDate(minutesToAdd: size).simplifyDateToHMM())")
                    }
                    HStack{
                        Text("Confidence level")
                        Spacer()
                        Text(getConfidenceOfSleeptimeInterval())
                    }
                    HStack{
                        if(dependentVariable == .quality){
                            Text("Average quality of day: ")
                        } else{
                            Text("Average productivity: ")
                        }
                        Spacer()
                        Text("\(calculateAverage())")
                    }
                    SliderView(name: "Interval size (minutes)",value: $size, lowValue: 15, highValue: 60)
                        .onChange(of: size){ _ in
                            updateOptimalInterval()
                        }.onAppear(){
                            updateOptimalInterval()
                        }.disabled(experiment.getSleepTimeRange()<30 || experiment.entries.count == 0)
                    if(experiment.getSleepTimeRange()<30){
                        Text("You need more data!")
                    }
                    
                }
                
            }.navigationTitle("Sleep time Scatterplot")
        }
    }
    private func getYAxisLabel() -> String{
        switch(experiment.dependentVariable){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both: return ""
        }
    }
    private func updateOptimalInterval(){
        if let ainterval = experiment.getOptimalSleepTimeInterval(size: size, dependentVariable: dependentVariable){
            interval = ainterval
        } else {
            interval = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        }
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
    private func calculateAverage()-> String{
        let average = experiment.averageOfSleepTimeInterval(at: SleepExperiment.getMinutes(from: interval), for: size, dependentVariable: dependentVariable)
        var hundredths = Int(average*100)
        let ones = hundredths / 100
        hundredths = hundredths % 100
        if(hundredths == 0){
            return "\(ones)"
        }
        return "\(ones).\(hundredths)"
    }
    func getConfidenceOfSleeptimeInterval() -> String{
        let pValue = experiment.getPValueOfSleeptimeInterval(interval: interval, size: size, dependentVariable: dependentVariable)
        let confidence = (1-pValue)*100
        return "\(Int(confidence))%"
    }
    
    
}

struct SleepTimeStatsHeader: View{
    var body: some View{
        
        NavigationLink(destination: SleepTimeStatsExplanation()){
            Image(systemName: "info.circle")
        }.font(Font.caption)
            .foregroundColor(.accentColor)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .overlay(
                Text("Stats"),
                alignment: .leading
            )
        
    }
}
struct SleepTimeScatterPlot_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeScatterPlot(experiment: SleepExperiment.hoursSleptSampleExperiment, dependentVariable: .quality)
    }
}
