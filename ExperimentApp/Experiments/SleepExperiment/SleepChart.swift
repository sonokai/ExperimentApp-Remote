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
    @State var buttonValue: ButtonValue = .bedtime
    //for both bedtime and waketime, create a button that switches the charts, for bedtime, waketime, and total time slept
    var interval: Date
    var size: Int
    var showRange = false
    enum ButtonValue: String{
        case bedtime = "Bedtime"
        case waketime = "WakeTime"
        case hoursSlept = "Hours Slept"
    }
    // for independent variable hours slept, just do normal display
    var body: some View {
        //if dependent var =  productivity or both display productivity chart
        
        // if dependent var = quality or both display quality chart
        //actually scratch that lets just make both display on the same chart
        
        VStack{
            switch(experiment.independentVariable){
            case .bedtime:
                BedtimeChart(experiment: experiment, interval: interval, size: size, showRange: showRange)
            case .waketime:
                WaketimeChart(experiment: experiment, interval: interval, size: size, showRange: showRange)
            case .both:
                BothtimeChart(experiment: experiment)
            case .hoursSlept:
                SleepTimeChart(experiment: experiment)
            }
        }
    }
}

struct SleepChart_Previews: PreviewProvider {
    static var previews: some View {
        SleepChart(experiment: SleepExperiment.bothTimesSampleExperiment, interval: Date(), size: 15)
    }
}
