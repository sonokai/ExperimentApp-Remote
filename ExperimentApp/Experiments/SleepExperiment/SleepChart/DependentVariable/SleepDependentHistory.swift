//
//  QualityHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI
import Charts
struct SleepDependentHistory: View {
    let experiment: SleepExperiment
    var dependentVariable: SleepExperiment.DependentVariable = .both
    //if dependentvariable is not both, then use the dependent vairable
    var body: some View {
        NavigationStack{
            Form{
                VStack(alignment: .leading){
                    if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                        Text("Quality of day history")
                    } else {
                        Text("Productivity history")
                    }
                    
                    Chart(experiment.entries){ entry in
                        if(experiment.dependentVariable == .quality || dependentVariable == .quality){
                            PointMark(
                                x: .value("Date", entry.date, unit: .day),
                                y: .value("Quality", entry.quality)
                            ).foregroundStyle(.red)
                        } else {
                            PointMark(
                                x: .value("Date", entry.date, unit: .day),
                                y: .value("Productivity", entry.productivity)
                            ).foregroundStyle(.blue)
                        }
                        
                    }
                    .frame(height: 300)
                    .chartXAxis{
                        AxisMarks(values: .stride(by: .day, count: getXAxisTickSize())){ value in
                            
                            if(getXAxisTickSize() >= 28){
                                AxisValueLabel{
                                    Text(getMonth(value.as(Date.self)))
                                }
                            } else {
                                AxisValueLabel{
                                    Text(formatToMonthAndDay(date: value.as(Date.self)))
                                }
                            }
                            
                            AxisGridLine()
                            AxisTick()
                        }
                    }
                    .chartXScale(domain: getXDomain())
                    .chartYAxisLabel(getChartYAxisLabel())
                }
                Section(){
                    if(dependentVariable == .quality || experiment.dependentVariable == .quality){
                        HStack{
                            Text("Average quality of day: ")
                            Spacer()
                            Text("\(experiment.getAverageQuality())")
                        }
                        HStack{
                            Text("Standard deviation: ")
                            Spacer()
                            Text("\(experiment.getQualityStandardDeviation().formatted(.number.precision(.fractionLength(2))))")
                        }
                    } else{
                        HStack{
                            Text("Average productivity: ")
                            Spacer()
                            Text("\(experiment.getAverageProductivity())")
                        }
                        HStack{
                            Text("Standard deviation: ")
                            Spacer()
                            Text("\(experiment.getProductivityStandardDeviation().formatted(.number.precision(.fractionLength(2))))")
                        }
                    }
                }.navigationTitle(getTitle())
            }
        }
    }
    func getTitle()->String{
        if(experiment.dependentVariable == .quality || dependentVariable == .quality){
            return "Quality data"
        } else {
            return "Productivity data"
        }
    }
    func getXAxisTickSize() -> Int{
        let (startDate, endDate) = experiment.getDateRange()
        let difference = endDate.timeIntervalSince(startDate)
        let daysDifference = difference / 86_400
        if(daysDifference >= 160){
            return 60
        }
        if(daysDifference >= 80){
            return 30
        }
        if(daysDifference >= 40){
            return 14
        }
        if(daysDifference >= 21){
            return 7
        }
        if(daysDifference >= 9){
            return 3
        }
        if(daysDifference >= 6){
            return 2
        }
        return 1
    }
    func getMonth(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        if let date1 = date {
            return dateFormatter.string(from: date1)
        } else {
            return "????"
        }
    }
    func formatToMonthAndDay(date: Date?) -> String {
        if let date1 = date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d"
            return dateFormatter.string(from: date1)
        } else {
            return "????"
        }
    }
    func getXDomain() -> ClosedRange<Date>{
        let (startDate, endDate) = experiment.getDateRange()
        let difference = endDate.timeIntervalSince(startDate)
        let daysDifference = difference / 86_400
        let tickSize = getXAxisTickSize()
        var totalTicks = daysDifference / Double(tickSize)
        totalTicks = totalTicks+1
        let timeToAdd = floor(totalTicks) * Double(tickSize) * 86_400
        return (startDate...startDate.addingTimeInterval(timeToAdd))
    }
    func getChartYAxisLabel() -> String{
        if(experiment.dependentVariable == .quality || dependentVariable == .quality){
            return "Quality of day"
        } else {
            return "Productivity history"
        }
    }
}

struct QualityHistory_Previews: PreviewProvider {
    static var previews: some View {
        SleepDependentHistory(experiment: SleepExperiment.bedtimeSampleExperiment, dependentVariable: .quality)
    }
}
