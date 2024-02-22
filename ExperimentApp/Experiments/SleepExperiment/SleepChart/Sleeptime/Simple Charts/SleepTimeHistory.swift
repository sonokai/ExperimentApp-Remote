//
//  SleepTimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct SleepTimeHistory: View {
    var experiment: SleepExperiment
    var body: some View {
        NavigationStack{
            Form{
                Section("Chart"){
                    VStack(alignment: .leading){
                        Text("Time slept")
                        Chart(experiment.entries){ entry in
                            PointMark(
                                x: .value("Date", entry.date.convertToMMDDYYYY(), unit: .day),
                                y: .value("Time slept", SleepExperiment.getSleepTimeSeconds(from: entry))
                            ).foregroundStyle(.red)
                        }.frame(height: 300)
                            .chartYAxis {
                                AxisMarks(values: .stride(by: experiment.getYAxisTickSize(independentVariable: .hoursSlept))) { value in
                                    AxisGridLine()
                                    if let value = value.as(Double.self) {
                                        AxisValueLabel {
                                            let minutes = Int(value)%3600/60
                                            if(minutes == 0){
                                                Text("\(Int(value)/3600):\(minutes)0")
                                            } else {
                                                Text("\(Int(value)/3600):\(minutes)")
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            .chartYScale(domain: experiment.getYDomain(independentVariable: .hoursSlept))
                            .chartXAxis{
                                AxisMarks(values: .stride(by: .day, count: experiment.getXAxisTickSize())){ value in
                                    if(xValueInRange(date: value.as(Date.self))){
                                        if(experiment.getXAxisTickSize() >= 28){
                                            AxisValueLabel{
                                                Text(Date.getMonth(value.as(Date.self)))
                                            }
                                        } else {
                                            AxisValueLabel{
                                                Text(Date.formatToMonthAndDay(date: value.as(Date.self)))
                                            }
                                        }
                                    }
                                    AxisGridLine()
                                    AxisTick()
                                }
                            }
                            .chartXScale(domain: experiment.getXDomain())
                        
                    }
                }
                Section("Stats"){
                    HStack{
                        Text("Average time slept:")
                        Spacer()
                        Text("\(experiment.getAverageSleepTime())")
                    }
                    HStack{
                        Text("Standard deviation:")
                        Spacer()
                        Text(experiment.formatStandardDeviation(independentVariable: .hoursSlept))
                    }
                    HStack{
                        Text("Median time slept:")
                        Spacer()
                        Text("\(experiment.getMedianSleepTime())")
                    }
                    
                    
                }
                
            }.navigationTitle(Text("Sleep time data"))
        }
    }
    func xValueInRange(date: Date?) -> Bool{
        let (_, endDate) = experiment.getDateRange()
        if let date1 = date{
            if(date1.timeIntervalSince1970>endDate.timeIntervalSince1970){
                return false
            }
        }
        return true
    }
}

struct SleepTimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeHistory(experiment: SleepExperiment.sleepTimeLargeRange)
    }
}
