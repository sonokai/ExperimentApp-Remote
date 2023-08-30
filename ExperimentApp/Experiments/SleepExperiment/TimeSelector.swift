//
//  TimeSelector.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/30/23.
//

import SwiftUI

struct TimeSelector: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    var body: some View {
        HStack{
            
            Picker("Hours", selection: $hours) {
                Text("").tag("")
                ForEach(0...12, id: \.self) { hour in
                    Text("\(hour)")
                }
            }.pickerStyle(.wheel)
            
            Text("Hours")
            
            Picker("Minutes", selection: $minutes) {
                Text("").tag("") //??
                ForEach(0...12, id: \.self) { hour in
                    Text("\(hour)")
                }
            }.pickerStyle(.wheel)
            Text("minutes")
            Spacer()
            
        }
    }
}

struct TimeSelector_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelector(hours:.constant(0), minutes: .constant(0))
    }
}
