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
    
    //for both bedtime and waketime, create a button that switches the charts, for bedtime, waketime, and total time slept
    
    // for independent variable hours slept, just do normal display
    var body: some View {
        //if dependent var =  productivity or both display productivity chart
        
        // if dependent var = quality or both display quality chart
        //actually scratch that lets just make both display on the same chart
        
        VStack{
            switch(experiment.independentVariable){
            case .bedtime:
                BedtimeResults(experiment: experiment)
            case .waketime:
                WaketimeResults(experiment: experiment)
            case .both:
                BothtimeChart(experiment: experiment)
            case .hoursSlept:
                SleepTimeStats(experiment: experiment)
            }
        }
    }
}

struct SleepChart_Previews: PreviewProvider {
    static var previews: some View {
        SleepChart(experiment: SleepExperiment.bothTimesSampleExperiment)
    }
}
