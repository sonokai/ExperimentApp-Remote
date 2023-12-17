//
//  WaketimeHistoryMessage.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/16/23.
//

import SwiftUI

struct WaketimeHistoryMessage: View {
    @State var comparisonWord = ""
    @State var minutes = 0
    var experiment: SleepExperiment
    var body: some View {
        VStack{
            
            if (minutes == 0){
                Text("Last week, your average waketime was \(SleepExperiment.getAverageWaketimeFromEntries(entries: experiment.entries.suffix(7)).simplifyDateToTimeString())")
            }else {
                Text("Last week, you woke up ") + Text("\(minutes) minutes").bold() + Text(" \(comparisonWord) than normal")
            }
        }.onAppear(){
            minutes = experiment.compareLastWeekWaketimeAverage()
            if(minutes < 0){
                comparisonWord = "earlier"
            } else {
                comparisonWord = "later"
            }
            minutes = abs(minutes)
        }
    }
}

struct WaketimeHistoryMessage_Previews: PreviewProvider {
    static var previews: some View {
        WaketimeHistoryMessage(experiment: SleepExperiment.waketimeSampleExperiment)
    }
}
