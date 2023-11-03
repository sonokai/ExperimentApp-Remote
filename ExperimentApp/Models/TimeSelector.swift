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
                
                ForEach(0...23, id: \.self) { hour in
                    Text("\(hour)")
                }
            }.pickerStyle(.wheel)
            
            Text("Hours")
            
            Picker("Minutes", selection: $minutes) {
                
                ForEach(0...59, id: \.self) { hour in
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
