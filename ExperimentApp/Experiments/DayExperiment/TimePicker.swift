//
//  TimePicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct TimePicker: View {
    @Binding var selection: DayExperiment.Time
    var independentVariable: DayExperiment.IndependentVariable
    var body: some View {
        Picker("Time",selection:$selection){
            ForEach(DayExperiment.Time.allCases){time in
                
                HStack{
                    TimeView(time:time).tag(time)
                    Spacer()
                }
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(selection: .constant(.afternoon), independentVariable: DayExperiment.sampleIndependentVariable)
    }
}
