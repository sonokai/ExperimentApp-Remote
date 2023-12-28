//
//  FinishedExperimentRow.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/26/23.
//

import SwiftUI

struct FinishedExperimentRow: View {
    var finishedExperiment: FinishedExperiment
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(finishedExperiment.name).font(.headline)
                Spacer()
                Image(systemName: "medal.fill").foregroundColor(.yellow)
            }
            HStack{
                Text("\(formatDateToString(finishedExperiment.startDate)) - \(formatDateToString(finishedExperiment.endDate))")
            }
        }
    }
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

}

struct FinishedExperimentRow_Previews: PreviewProvider {
    static var previews: some View {
        FinishedExperimentRow(finishedExperiment: FinishedExperiment.sample)
    }
}
