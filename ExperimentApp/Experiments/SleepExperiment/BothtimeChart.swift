//
//  BothtimeChart.swift
//  ExperimentApp
//
//  Created by Bell Chen on 10/14/23.
//

import SwiftUI

struct BothtimeChart: View {
    var experiment: SleepExperiment
    @State var buttonValue: ButtonValue = .bedtime
    //for both bedtime and waketime, create a button that switches the charts, for bedtime, waketime, and total time slept
    enum ButtonValue: String{
        case bedtime = "Bedtime"
        case waketime = "WakeTime"
        case hoursSlept = "Hours Slept"
    }

    var body: some View {
        Picker("display", selection: $buttonValue){
            Text("Bedtime").tag(ButtonValue.bedtime)
            Text("Waketime").tag(ButtonValue.waketime)
            Text("Total time slept").tag(ButtonValue.hoursSlept)
        }.pickerStyle(.segmented)
        
        switch(buttonValue){
        case .bedtime:
            //BedtimeChart(experiment: experiment)
            Text("Temporary")
        case .waketime:
            WaketimeChart(experiment: experiment)
        case .hoursSlept:
            SleepTimeChart(experiment: experiment)
        }
        
    }
}

struct BothtimeChart_Previews: PreviewProvider {
    static var previews: some View {
        BothtimeChart(experiment: SleepExperiment.bothTimesSampleExperiment)
    }
}
