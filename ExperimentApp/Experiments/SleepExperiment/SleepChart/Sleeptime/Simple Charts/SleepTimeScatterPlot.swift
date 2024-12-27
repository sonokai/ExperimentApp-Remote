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
    
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    @State var entriesRequired: Int = 1
    @State var showTheThingy: Bool = false
    @State var optimalIntervalIsValid: Bool = true
    @State var errorMessage = ""
    var body: some View {
        NavigationStack{
            Form{
                Section(header: ChartHeaderAndSettings(showTheThingy: $showTheThingy)){
                    VStack(alignment:.leading){
                        
                        Text(SleepExperiment.getChartTitle2(independentVariable: .hoursSlept, dependentVariable: dependentVariable)).font(.headline)
                        
                        Chart(){
                            if(showRange && optimalIntervalIsValid){
                                RectangleMark(
                                    xStart: .value("Start of interval", convertDate(from: interval)),
                                    xEnd: .value("End of best interval", addMinutesToDate(date: interval, minutesToAdd: size)),
                                    yStart: nil,
                                    yEnd: nil
                                ).foregroundStyle(.green)
                            }
                            
                            ForEach(experiment.entries){ entry in
                                if(formatTime(hour: entry.hoursSlept, minute: entry.minutesSlept) >= startTime && formatTime(hour: entry.hoursSlept, minute: entry.minutesSlept) <= endTime){
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
                        }
                        .onAppear(){
                            var startMinutes = experiment.getLeastSleepTimeMinutes()
                            var endMinutes = experiment.getMostSleepTimeMinutes()
                            if(startMinutes % 30 != 0){
                                startMinutes = startMinutes-(startMinutes%30)
                            }
                            if(endMinutes % 30 != 0){
                                endMinutes = endMinutes + (30-(endMinutes%30))
                            }
                            startTime = formatTime(hour: startMinutes/60, minute: startMinutes%60)
                            endTime = formatTime(hour: endMinutes/60, minute: endMinutes%60)
                            updateOptimalInterval()
                        }
                        .chartXScale(domain: [startTime, endTime])
                        .chartYAxisLabel(experiment.getYAxisLabel(dependentVariable))
                        .chartXAxisLabel("Time slept")
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
                }.sheet(isPresented: $showTheThingy){
                    SleepTimeSettings(startDate: $startTime, endDate: $endTime, entriesRequired: $entriesRequired).onDisappear(){
                        updateOptimalInterval()
                    }
                }
                Section(header: SleepTimeStatsHeader()){
                    Toggle("Show optimal sleep time", isOn: $showRange).disabled(!optimalIntervalIsValid)
                    
                    HStack{
                        Text("Optimal sleep time")
                        Spacer()
                        if(optimalIntervalIsValid){
                            Text("\(interval.simplifyDateToHMM()) - \(interval.addMinutesToDate(minutesToAdd: size).simplifyDateToHMM())")
                        }else {
                            Text("-")
                        }
                    }
                    /*
                    HStack{
                        Text("Confidence level")
                        Spacer()
                        if(optimalIntervalIsValid){
                            Text(getConfidenceOfSleeptimeInterval())
                        }else {
                            Text("-")
                        }
                    }
                    */
                    HStack{
                        if(dependentVariable == .quality){
                            Text("Quality of day of best sleep time ")
                        } else{
                            Text("Productivity of best sleep time")
                        }
                        Spacer()
                        if(optimalIntervalIsValid){
                            Text("\(calculateAverage())")
                        } else {
                            Text("-")
                        }
                        
                    }
                    /*
                    if(experiment.getSleepTimeRange() >= 15){
                        SliderView(name: "Optimal interval size",value: $size, lowValue: 15, highValue: 60)
                            .onChange(of: size){ _ in
                                updateOptimalInterval()
                            }.onAppear(){
                                if(experiment.getSleepTimeRange()<30){
                                    size = 15
                                }
                                updateOptimalInterval()
                            }
                    }
                    */
                    if(!optimalIntervalIsValid){
                        Text(errorMessage)
                    }
                    
                }
                
            }.navigationTitle("Sleep time Scatterplot")
        }
    }
    private func updateOptimalInterval(){
        switch(experiment.getOptimalSleepTimeInterval(dependentVariable: dependentVariable, requiredEntries: entriesRequired, lowEndpoint: getMinutes(startTime), highEndpoint: getMinutes(endTime))){
        case .success(let optimalInterval):
            interval = optimalInterval
            optimalIntervalIsValid = true
            print("Sucess!")
        case .failure(let error):
            print("YOu suck")
            errorMessage = error.description
            optimalIntervalIsValid = false
        }
    }
    func getMinutes(_ date: Date)-> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        if let hour = components.hour, let minute = components.minute {
            return hour * 60 + minute
        } else {
            // Handle the case where date components cannot be obtained
            return 0
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
