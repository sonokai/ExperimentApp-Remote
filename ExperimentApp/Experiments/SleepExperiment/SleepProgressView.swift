//
//  SleepProgressView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import SwiftUI

struct SleepProgressView: View {
    var experiment: SleepExperiment
    var body: some View {
        ProgressView(value: Double(experiment.entries.count)/Double(experiment.goalEntries)){
            
            if(experiment.entries.count < experiment.goalEntries){
                Text("\(experiment.entries.count)/\(experiment.goalEntries) goal entries (\(Int(Double(experiment.entries.count)/Double(experiment.goalEntries)*100))% Progress) ").padding(.bottom, 5)
            }else {
                HStack{
                    Text("\(experiment.entries.count)/\(experiment.goalEntries) entries").padding(.bottom, 5)
                    Spacer()
                    
                    switch(experiment.entries.count){
                    case 0...15:
                        Text("")
                    case 15...25:
                        Image("medal.fill").foregroundColor(.brown)
                    case 25...50:
                        Image("medal.fill").foregroundColor(.gray)
                    default:
                        Image("medal.fill").foregroundColor(.yellow)
                    }
                }
            }
        }.padding(.vertical, 10)
    }
}

struct SleepProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SleepProgressView(experiment: SleepExperiment.bedtimeSampleExperiment)
    }
}
