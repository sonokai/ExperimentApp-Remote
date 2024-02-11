//
//  EmptyChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 2/7/24.
//

import SwiftUI
import Charts
struct EmptyChart: View {
    struct fillerData: Identifiable{
        let id: UUID
        let name: String
        let value: Int
        
        init(id: UUID = UUID(), name: String, value: Int) {
            self.id = id
            self.name = name
            self.value = value
        }
        static let fillerDataSet: [fillerData] = [
            fillerData(name: "hi", value: 1),
            fillerData(name: "meow", value: 2),
            fillerData(name: "qj", value: 3),
            fillerData(name: "hiq", value: 4),
            fillerData(name: "hi3", value: 5),
        ]
    }
    var body: some View {
        Chart(fillerData.fillerDataSet){ fillerData in
            BarMark(
                x: .value("Date", fillerData.name),
                y: .value("Bedtime", fillerData.value)
            ).foregroundStyle(.gray)
        }.chartXAxis(.hidden)
            .frame(height: 120)
            .chartYAxis(.hidden)
    }
}

struct EmptyChart_Previews: PreviewProvider {
    static var previews: some View {
        EmptyChart()
    }
}
