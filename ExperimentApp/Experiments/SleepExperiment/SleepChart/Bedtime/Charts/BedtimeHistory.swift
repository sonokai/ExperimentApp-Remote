//
//  BedtimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/14/23.
//

import SwiftUI
import Charts
//this crashes if you get two of the same date
struct BedtimeHistory: View {
    var experiment: SleepExperiment
    @State var showFullRange = false
    var body: some View {
        Form{
            Section("Chart"){
                VStack(alignment: .leading){
                    Text("Bedtimes")
                    Chart(experiment.entries){ entry in
                        PointMark(
                            x: .value("Date", entry.date.convertToMMDDYYYY(), unit: .day),
                            y: .value("Bedtime", SleepExperiment.getBedtimeSeconds(from: entry.bedtime))
                        ).foregroundStyle(.red)
                    }.frame(height: 300)
                        .chartYAxis {
                            AxisMarks(values: .stride(by: experiment.getYAxisTickSize(independentVariable: .bedtime))) { value in
                                AxisGridLine()
                                
                                if let value = value.as(Double.self) {
                                    AxisValueLabel {
                                        //Text("\(value)")
                                        Text(Date.simplifySecondsToTimeString(value))
                                    }
                                }
                            }
                        }
                        .chartYScale(domain: experiment.getYDomain(independentVariable: .bedtime))
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
                    Text("Average bedtime: ")
                    Spacer()
                    Text("\(experiment.getAverageBedtime())")
                }
                HStack{
                    Text("Standard deviation:")
                    Spacer()
                    Text(experiment.formatStandardDeviation(independentVariable: .bedtime))
                }
                HStack{
                    Text("Median bedtime: ")
                    Spacer()
                    Text("\(experiment.getMedianBedtime())")
                }
                

            }
            
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

struct BedtimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeHistory(experiment: SleepExperiment.bedtimeSampleExperiment)
    }
}
