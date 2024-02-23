//
//  BedtimeData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/23/23.
//

import SwiftUI

struct BedtimeData: View {
    var experiment: SleepExperiment
    var body: some View {
        
            NavigationLink(destination: BedtimeHistory(experiment: experiment)){
                SimpleBedtimeHistory(experiment: experiment)
            }
        
    }
}

struct BedtimeData_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Form{
                Section("Bedtime data"){
                    BedtimeData(experiment: SleepExperiment.bedtimeSampleExperiment)
                }
            }
        }
    }
}
