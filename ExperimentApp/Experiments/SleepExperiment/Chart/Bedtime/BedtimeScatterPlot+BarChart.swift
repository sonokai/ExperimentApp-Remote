//
//  BedtimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/16/23.
//

import SwiftUI
import Charts

struct BedtimeScatterPlot: View {
    var experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable
    @State var interval: Date = Date()
    @State var size: Int = 15
    @State var showRange: Bool = false
    
    var body: some View {
        Form{
            Section("Chart"){
                VStack(alignment:.leading){
                    
                    Text(SleepExperiment.getChartTitle2(independentVariable: .bedtime, dependentVariable: dependentVariable)).font(.headline)
                    
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
                    
                    .chartXScale()
                    .chartYAxisLabel(getYAxisLabel())
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
            }
            Section("Settings"){
                
                Toggle("Show optimal interval", isOn: $showRange)
                if(showRange){
                    HStack{
                        Text("Optimal interval:")
                        Spacer()
                        Text("\(interval.simplifyDateToTimeString()) - \(interval.addMinutesToDate(minutesToAdd: size).simplifyDateToTimeString())")
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
                    
                    SliderView(name: "Interval size (minutes)",value: $size, lowValue: 5, highValue: 30 > experiment.getBedtimeRange() ?  (Double)(experiment.getBedtimeRange()) : 30)
                        .onChange(of: size){ _ in
                            updateInterval()
                        }.onAppear(){
                            updateInterval()
                        }.disabled(experiment.getBedtimeRange()<5 || experiment.entries.count == 0)
                    if(experiment.getBedtimeRange()<5){
                        Text("You need more data!")
                    }
                }
            }
            Section("Bar chart"){
                BedtimeBarChart(experiment: experiment, dependentVariable: dependentVariable)
            }
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
        if let tempinterval =
            experiment.getOptimalBedtimeInterval(size: size, dependentVariable: dependentVariable){
            interval = tempinterval
        } else {
            interval = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        }
    }
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
    
    
    
    
}

struct BedtimeChart_Previews: PreviewProvider {
    static let testInterval: Date = Calendar.current.date(bySettingHour: 10, minute: 50, second: 0, of: Date())!
    static var previews: some View {
        BedtimeScatterPlot(experiment: SleepExperiment.midnightSampleExperiment, dependentVariable: .quality ,interval: testInterval, size: 15)
    }
}
