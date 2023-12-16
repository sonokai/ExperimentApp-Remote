//
//  DateChartTest.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/1/23.
//

import SwiftUI
import Charts
struct DateChartTest: View {
    let time1 = Calendar.current.date(bySettingHour: 21, minute: 30, second: 0, of: Date(timeIntervalSince1970: TimeInterval(0)))!
    let time2 = Calendar.current.date(bySettingHour: 22, minute: 30, second: 0, of: Date(timeIntervalSince1970: TimeInterval(0)))!
    let time3 = Calendar.current.date(bySettingHour: 23, minute: 30, second: 0, of: Date(timeIntervalSince1970: TimeInterval(0)))!
    let time4 = Calendar.current.date(bySettingHour: 0, minute: 30, second: 0, of: Date(timeIntervalSince1970: TimeInterval(24*3600)))!
    
    var body: some View {
        Chart{
            
            PointMark(
                x: .value("Date", createDate(month: 12, day: 1, year: 2023)),
                y: .value("Bedtime", time1)
            )
            PointMark(
                x: .value("Date", createDate(month: 12, day: 2, year: 2023)),
                y: .value("Bedtime", time2)
            )
            PointMark(
                x: .value("Date", createDate(month: 12, day: 3, year: 2023)),
                y: .value("Bedtime", time3)
            )
            PointMark(
                x: .value("Date", createDate(month: 12, day: 4, year: 2023)),
                y: .value("Bedtime", time4)
            )
            PointMark(
                x: .value("Date", createDate(month: 12, day: 5, year: 2023)),
                y: .value("Bedtime", time4)
            )
            
            
        }.frame(height: 300).padding()
    }
    private func createDate(month: Int, day: Int, year: Int) -> Date {
            var components = DateComponents()
            components.month = month
            components.day = day
            components.year = year

            let calendar = Calendar.current
            return calendar.date(from: components) ?? Date()
    }
}

struct DateChartTest_Previews: PreviewProvider {
    static var previews: some View {
        DateChartTest()
    }
}
