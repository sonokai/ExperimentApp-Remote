//
//  BedtimeHistoryMessage.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/15/23.
//

import SwiftUI

struct BedtimeHistoryMessage: View {
    @State var comparisonWord = ""
    @State var minutes = 0
    var experiment: SleepExperiment
    var body: some View {
        VStack{
            
            if (minutes == 0 || experiment.entries.count < 14){
                Text("Last week, your average bedtime was") + Text(" \(SleepExperiment.getAverageBedtimeFromEntries(entries: experiment.entries.suffix(7)).simplifyDateToTimeString())").bold()
            }else {
                Text("Last week, you slept ") + Text("\(minutes) minutes").bold() + Text("  \(comparisonWord) than normal")
            }
        }.onAppear(){
            minutes = experiment.compareLastWeekBedtimeAverage()
            if(minutes < 0){
                comparisonWord = "earlier"
            } else {
                comparisonWord = "later"
            }
            minutes = abs(minutes)
        }
    }
    
}

struct BedtimeHistoryMessage_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeHistoryMessage(experiment: SleepExperiment.bedtimeSampleExperiment)
    }
}
