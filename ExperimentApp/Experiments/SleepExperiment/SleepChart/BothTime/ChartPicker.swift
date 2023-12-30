
//
//  ChartPicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/13/23.
//

import SwiftUI

struct ChartPicker: View {
    
    @Binding var pickerValue: pickerValues
    enum pickerValues : String{
        case bedtime = "quality"
        case waketime = "productivity"
        case sleeptime = "compare"
    }
    var body: some View {
        Picker("Chart Y axis",selection: $pickerValue){
            Text("Bedtime").tag(pickerValues.bedtime)
            Text("Wake time").tag(pickerValues.waketime)
            Text("Time slept").tag(pickerValues.sleeptime)
        }
        .pickerStyle(.segmented)

    }
}

struct ChartPicker_Previews: PreviewProvider {
    static var previews: some View {
        ChartPicker(pickerValue: .constant(.bedtime))
    }
}
