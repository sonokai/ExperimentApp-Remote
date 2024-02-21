//
//  FinishedExperimentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/26/23.
//

import SwiftUI

struct FinishedExperimentView: View {
    var finishedExperiment: FinishedExperiment
    var body: some View {
        NavigationStack{
            Form{
                HStack{
                    Text("\(formatDateToString(finishedExperiment.startDate)) - \(formatDateToString(finishedExperiment.endDate))")
                }
                Section("Insights"){
                    ForEach(finishedExperiment.insights, id: \.self){ insight in
                        VStack(alignment:.leading){
                            Text(Date.formatToMonthAndDay(date: insight.date)).bold()
                            Text(insight.text)
                        }
                    }
                }
            }.navigationTitle(finishedExperiment.name)
        }
    }
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

struct FinishedExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedExperimentView(finishedExperiment: FinishedExperiment.sample)
    }
}
