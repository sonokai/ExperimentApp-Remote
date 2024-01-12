//
//  SleepPicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/20/23.
//

import SwiftUI

struct SleepPicker: View {
    var label: String
    @Binding var value: Int
    var body: some View {
        Picker(label, selection: $value){
            ForEach(1..<11){ number in
                Text("\(number)").tag(number)
            }
        }
    }
}

struct SleepPicker_Previews: PreviewProvider {
    static var previews: some View {
        SleepPicker(label: "Quality of day",value: .constant(1))
    }
}
