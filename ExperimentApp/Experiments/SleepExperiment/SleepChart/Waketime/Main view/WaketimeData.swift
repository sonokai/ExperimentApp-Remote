//
//  WaketimeData.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/23/23.
//

import SwiftUI

struct WaketimeData: View {
    var experiment: SleepExperiment
    var body: some View {
        
            NavigationLink(destination: WakeTimeHistory(experiment: experiment)){
                SimpleBedtimeHistory(experiment: experiment)
            }
        
    }
}

struct WaketimeData_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Form{
                WaketimeData(experiment: SleepExperiment.waketimeSampleExperiment)
            }
        }
    }
}
