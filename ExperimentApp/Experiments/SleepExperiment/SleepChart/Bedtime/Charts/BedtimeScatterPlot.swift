//
//  BedtimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts

//will crash if you put in an empty array of sleep entries
struct BedtimeScatterPlot: View {
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
                        
                        Text(SleepExperiment.getChartTitle2(independentVariable: .bedtime, dependentVariable: dependentVariable)).font(.headline)
                        
                        Chart(){
                            if(showRange && optimalIntervalIsValid){
                                RectangleMark(
                                    xStart: .value("Start of interval", interval.formatDateForChart()),
                                    xEnd: .value("End of best interval", interval.addMinutesToDate(minutesToAdd: size)),
                                    yStart: nil,
                                    yEnd: nil
                                ).foregroundStyle(.green)
                            }
                            
                            ForEach(experiment.entries){ entry in
                                if(entry.bedtime.formatDateForChart() >=  startTime && entry.bedtime.formatDateForChart() <= endTime){
                                    if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                                        PointMark(
                                            x: .value("Bedtime", entry.bedtime.formatDateForChart()),
                                            y: .value("Quality", entry.quality)
                                        ).foregroundStyle(.red)
                                    }
                                    if(experiment.dependentVariable == .productivity || dependentVariable == .productivity){
                                        PointMark(
                                            x: .value("Bedtime", entry.bedtime.formatDateForChart()),
                                            y: .value("Productivity", entry.productivity)
                                        ).foregroundStyle(.blue)
                                    }
                                }
                                
                            }
                        }
                        .onAppear(){
                            let startMinutes = experiment.getLeastBedtimeMinutes()
                            let endMinutes = experiment.getMostBedtimeMinutes()
                            if let t1 = convertMinutesToDate(startMinutes){
                                startTime = t1.formatDateForChart()
                            }
                            if let t2 = convertMinutesToDate(endMinutes){
                                endTime = t2.formatDateForChart()
                            }
                            updateInterval()
                        }
                        
                        .chartXScale(domain: [startTime,endTime])
                        .chartYAxisLabel(experiment.getYAxisLabel(dependentVariable))
                        .chartXAxisLabel("Bedtime")
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
                    }
                    .padding()
                }.sheet(isPresented: $showTheThingy){
                    BedtimeSettings(startDate: $startTime, endDate: $endTime, entriesRequired: $entriesRequired).onDisappear(){
                        updateInterval()
                    }
                }
                Section(header: BedtimeStatsHeader()){
                    
                    Toggle("Show optimal interval", isOn: $showRange).disabled(!optimalIntervalIsValid)
                    HStack{
                        Text("Optimal interval")
                        Spacer()
                        if(optimalIntervalIsValid){
                            Text("\(interval.simplifyDateToTimeString()) - \(interval.addMinutesToDate(minutesToAdd: size).simplifyDateToTimeString())")
                        } else {
                            Text("-")
                        }
                        
                    }
                    HStack{
                        Text("Confidence level")
                        Spacer()
                        if(optimalIntervalIsValid){
                            Text(getConfidenceOfBedtimeInterval())
                        }else {
                            Text("-")
                        }
                    }
                    HStack{
                        if(dependentVariable == .quality){
                            Text("Quality of day of optimal interval")
                        } else{
                            Text("Productivity of optimal interval")
                        }
                        Spacer()
                        if(optimalIntervalIsValid){
                            Text("\(calculateAverage())")
                        }else {
                            Text("-")
                        }
                        
                    }
                    
                    if(experiment.getBedtimeRange() >= 15){
                        SliderView(name: "Interval size (minutes)",value: $size, lowValue: 15, highValue: 60 > experiment.getBedtimeRange() ?  (Double)(experiment.getBedtimeRange()) : 60)
                            .onChange(of: size){ _ in
                                updateInterval()
                            }.onAppear(){
                                if(experiment.getBedtimeRange()<30){
                                    size = 15
                                }
                                updateInterval()
                            }
                    }
                    
                    
                    if(!optimalIntervalIsValid){
                        Text(errorMessage)
                    }
                } //end of stats
                
            }.navigationTitle("Bedtime Scatterplot")
        }
        
    }
    func getConfidenceOfBedtimeInterval() -> String{
        let pValue = experiment.getPValueOfBedtimeInterval(interval: interval, size: size, dependentVariable: dependentVariable)
        let confidence = (1-pValue)*100
        return "\(Int(confidence))%"
    }
    
    private func updateInterval(){
        
        switch(experiment.getOptimalBedtimeInterval(size: size, dependentVariable: dependentVariable, lowEndpoint: startTime, highEndpoint: endTime, requiredEntries: entriesRequired)){
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
    //calculates average of dependent variable from the interval
    private func calculateAverage()-> String{
        let average = experiment.averageOfBedtimeInterval(at: SleepExperiment.getBedtimeMinutes(from: interval), for: size, dependentVariable: dependentVariable)
        var hundredths = Int(average*100)
        let ones = hundredths / 100
        hundredths = hundredths % 100
        if(hundredths == 0){
            return "\(ones)"
        }
        return "\(ones).\(hundredths)"
    }
    func convertMinutesToDate(_ minutes: Int) -> Date?{
        var minutes = minutes
        var day = 1
        if(minutes > 1440){
            minutes = minutes - 1440
            day = 2
        }
        return Calendar.current.date(bySettingHour: minutes/60, minute: minutes % 60, second: 0, of: Date(timeIntervalSinceReferenceDate: TimeInterval(day * 24 * 3600)))
    }
}


struct BedtimeStatsHeader: View{
    var body: some View{
        
        NavigationLink(destination: BedtimeStatsExplanation()){
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

struct BedtimeChart_Previews: PreviewProvider {
    static let testInterval: Date = Calendar.current.date(bySettingHour: 10, minute: 50, second: 0, of: Date())!
    static var previews: some View {
        
        BedtimeScatterPlot(experiment: SleepExperiment.bedtimeSampleExperiment2, dependentVariable: .productivity ,interval: testInterval, size: 30)
    }
}
