//
//  FinishedExperimentRow.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/26/23.
//

import SwiftUI

struct FinishedExperimentRow: View {
    var name: String
    var startDate: Date
    var endDate: Date
    var medal: Medal
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(name).font(.headline)
                Spacer()
                switch(medal){
                case .none:
                    Text("")
                case .bronze:
                    Image(systemName: "medal.fill").foregroundColor(.brown)
                case .silver:
                    Image(systemName: "medal.fill").foregroundColor(.gray)
                case .gold:
                    Image(systemName: "medal.fill").foregroundColor(.yellow)
                }
                
            }
            HStack{
                Text("\(formatDateToString(startDate)) - \(formatDateToString(endDate))")
            }
        }
    }
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

}

struct FinishedExperimentRow_Previews: PreviewProvider {
    static var previews: some View {
        FinishedExperimentRow(name: "Activity", startDate: Date(timeIntervalSinceNow: -600000), endDate: Date(timeIntervalSinceNow: -30), medal: .none)
    }
}
