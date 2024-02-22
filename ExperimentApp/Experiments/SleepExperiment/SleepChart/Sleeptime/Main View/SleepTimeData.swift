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
        
        NavigationLink(destination: SleepTimeHistory(experiment: experiment)){
            SimpleSleepTimeHistory(experiment: experiment)
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
