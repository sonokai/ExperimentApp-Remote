//
//  WaketimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts

struct WaketimeScatterPlot: View {
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
                        
                        Text(SleepExperiment.getChartTitle2(independentVariable: .waketime, dependentVariable: dependentVariable)).font(.headline)
                        
                        Chart(){
                            if(showRange && optimalIntervalIsValid){
                                RectangleMark(
                                    xStart: .value("Start of interval", interval.formatDateForNonBedtimeChart()),
                                    xEnd: .value("End of best interval", interval.addMinutesToDate(minutesToAdd: size).formatDateForNonBedtimeChart()),
                                    yStart: nil,
                                    yEnd: nil
                                ).foregroundStyle(.green)
                            }
                            
                            ForEach(experiment.entries){ entry in
                                if(entry.waketime.formatDateForNonBedtimeChart() >=  startTime && entry.waketime.formatDateForNonBedtimeChart() <= endTime){
                                    if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                                        PointMark(
                                            x: .value("Waketime", entry.waketime.formatDateForNonBedtimeChart()),
                                            y: .value("Quality", entry.quality)
                                        ).foregroundStyle(.red)
                                    }
                                    if(experiment.dependentVariable == .productivity || dependentVariable == .productivity){
                                        PointMark(
                                            x: .value("Waketime", entry.waketime.formatDateForNonBedtimeChart()),
                                            y: .value("Productivity", entry.productivity)
                                        ).foregroundStyle(.blue)
                                    }
                                }
                                
                            }
                        }
                        .onAppear(){
                            let startMinutes = experiment.getLeastWaketimeMinutes()
                            let endMinutes = experiment.getMostWaketimeMinutes()
                            if let t1 = convertMinutesToDate(startMinutes){
                                startTime = t1.formatDateForNonBedtimeChart()
                            }
                            if let t2 = convertMinutesToDate(endMinutes){
                                endTime = t2.formatDateForNonBedtimeChart()
                            }
                            updateInterval()
                        }
                        
                        .chartXScale(domain: [startTime,endTime])
                        .chartYAxisLabel(getYAxisLabel())
                        .chartXAxisLabel("Waketime")
                        
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
                    WaketimeSettings(startDate: $startTime, endDate: $endTime, entriesRequired: $entriesRequired).onDisappear(){
                        updateInterval()
                    }
                }
                Section(header: WaketimeStatsHeader()){
                    
                    Toggle("Show optimal interval", isOn: $showRange)
                    HStack{
                        Text("Optimal interval:")
                        Spacer()
                        if(optimalIntervalIsValid){
                            Text("\(interval.simplifyDateToTimeString()) - \(interval.addMinutesToDate(minutesToAdd: size).simplifyDateToTimeString())")
                        } else {
                            Text("Error")
                        }
                    }
                    HStack{
                        Text("Confidence level")
                        Spacer()
                        if(optimalIntervalIsValid){
                            Text(getConfidenceOfWaketimeInterval())
                        }else {
                            Text("-")
                        }
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
                    
                    SliderView(name: "Interval size (minutes)",value: $size, lowValue: 15, highValue: 60 > experiment.getWaketimeRange() ?  (Double)(experiment.getWaketimeRange()) : 60)
                        .onChange(of: size){ _ in
                            updateInterval()
                        }.onAppear(){
                            updateInterval()
                        }.disabled(experiment.getWaketimeRange()<30 || experiment.entries.count == 0)
                    if(experiment.getWaketimeRange()<30){
                        Text("You need more data!")
                    }
                    if(!optimalIntervalIsValid){
                        Text(errorMessage)
                    }
                }
            }.navigationTitle("Wake time Scatterplot")
        }
    }
    
    private func getYAxisLabel() -> String{
        switch(experiment.dependentVariable){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both: return ""
        }
    }
    private func updateInterval(){
        switch(
            experiment.getOptimalWaketimeInterval(size: size, dependentVariable: dependentVariable, lowEndpoint: startTime, highEndpoint: endTime, requiredEntries: entriesRequired)){
        case .success(let optimalInterval):
            interval = optimalInterval
            optimalIntervalIsValid = true
        case .failure(let error):
            errorMessage = error.description
            optimalIntervalIsValid = false
        }
    }
    private func calculateAverage()-> String{
        let average = experiment.averageOfWaketimeInterval(at: SleepExperiment.getWaketimeMinutes(from: interval), for: size, dependentVariable: dependentVariable)
        var hundredths = Int(average*100)
        let ones = hundredths / 100
        hundredths = hundredths % 100
        if(hundredths == 0){
            return "\(ones)"
        }
        return "\(ones).\(hundredths)"
    }
    func getConfidenceOfWaketimeInterval() -> String{
        let pValue = experiment.getPValueOfWaketimeInterval(interval: interval, size: size, dependentVariable: dependentVariable)
        let confidence = (1-pValue)*100
        return "\(Int(confidence))%"
    }
    func convertMinutesToDate(_ minutes: Int) -> Date?{
        let minutes = minutes
        return Calendar.current.date(bySettingHour: minutes/60, minute: minutes % 60, second: 0, of: Date())
    }
}
struct WaketimeStatsHeader: View{
    var body: some View{
        
        NavigationLink(destination: WaketimeStatsExplanation()){
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

struct WaketimeChart_Previews: PreviewProvider {
    static let testInterval: Date = Calendar.current.date(bySettingHour: 10, minute: 50, second: 0, of: Date())!
    static var previews: some View {
        WaketimeScatterPlot(experiment: SleepExperiment.waketimeSampleExperiment, dependentVariable: .productivity)
    }
}
