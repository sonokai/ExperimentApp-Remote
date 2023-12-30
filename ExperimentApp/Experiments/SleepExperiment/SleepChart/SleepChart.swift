//
//  SleepChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/15/23.
//

import SwiftUI
import Charts
struct SleepChart: View {
    var experiment: SleepExperiment
    
    var body: some View {
        
        VStack{
            switch(experiment.independentVariable){
            case .bedtime:
                BedtimeResults(experiment: experiment)
            case .waketime:
                WaketimeResults(experiment: experiment)
            case .both:
                BothTimeResults(experiment: experiment)
            case .hoursSlept:
                SleepTimeResults(experiment: experiment)
            }
        }
    }
}

struct SleepChart_Previews: PreviewProvider {
    static var previews: some View {
        SleepChart(experiment: SleepExperiment.bothTimesSampleExperiment)
    }
}
