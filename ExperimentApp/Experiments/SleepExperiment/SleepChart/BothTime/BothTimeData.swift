//
//  BothTimeData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/24/23.
//

import SwiftUI

struct BothTimeData: View {
    var experiment: SleepExperiment
    var body: some View {
        if(experiment.entries.count>=7){
            NavigationLink(destination: BedtimeHistory(experiment: experiment)){
                SimpleBedtimeHistory(experiment: experiment)
            }
            NavigationLink(destination: WakeTimeHistory(experiment: experiment)){
                SimpleWaketimeHistory(experiment: experiment)
            }
            NavigationLink(destination: SleepTimeHistory(experiment: experiment)){
                SimpleSleepTimeHistory(experiment: experiment)
            }
        } else{
            EntryProgressView(count: experiment.entries.count, needed: 7, text: "to view bedtime data")
        }
    }
}

struct BothTimeData_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Form{
                
                BothTimeData(experiment: SleepExperiment.bothTimesSampleExperiment)
            }
        }
    }
}
