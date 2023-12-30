//
//  SleepTimeData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/24/23.
//

import SwiftUI

struct SleepTimeData: View {
    var experiment: SleepExperiment
    var body: some View {
        if(experiment.entries.count>=7){
            NavigationLink(destination: SleepTimeHistory(experiment: experiment)){
                SimpleSleepTimeHistory(experiment: experiment)
            }
        } else{
            EntryProgressView(count: experiment.entries.count, needed: 7, text: "to view bedtime data")
        }
    }
}

struct SleepTimeData_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Form{
                SleepTimeData(experiment: SleepExperiment.hoursSleptSampleExperiment)
            }
        }
    }
}
