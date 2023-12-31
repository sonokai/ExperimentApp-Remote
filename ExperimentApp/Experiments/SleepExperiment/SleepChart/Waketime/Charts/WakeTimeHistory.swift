//
//  WakeTimeHistory.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI
import Charts
struct WakeTimeHistory: View {
    var experiment: SleepExperiment
    
    var body: some View {
        Form{
            Section("Chart"){
                VStack(alignment: .leading){
                    Text("Waketimes")
                    Chart(experiment.entries){ entry in
                        PointMark(
                            x: .value("Date", entry.date.convertToMMDDYYYY(), unit: .day),
                            y: .value("Waketime", SleepExperiment.getWaketimeSeconds(from: entry.waketime))
                        ).foregroundStyle(.red)
                    }.frame(height: 300)
                        .chartYAxis {
                            AxisMarks(values: .stride(by: experiment.getYAxisTickSize(independentVariable: .waketime))) { value in
                                AxisGridLine()
                                
                                if let value = value.as(Double.self) {
                                    AxisValueLabel {
                                        Text(Date.simplifySecondsToTimeString(value))
                                    }
                                }
                            }
                        }
                        .chartYScale(domain: experiment.getYDomain(independentVariable: .waketime))
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
                    Text("Average wake time: ")
                    Spacer()
                    Text("\(experiment.getAverageWaketime())")
                }
                HStack{
                    Text("Standard deviation:")
                    Spacer()
                    Text(experiment.formatStandardDeviation(independentVariable: .waketime))
                }
                HStack{
                    Text("Median wake time: ")
                    Spacer()
                    Text("\(experiment.getMedianWaketime())")
                }
                

            }
            
        }.navigationTitle(Text("Waketime data"))
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

struct WakeTimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        WakeTimeHistory(experiment: SleepExperiment.testCrash)
    }
}
