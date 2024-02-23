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
    
    @State var wheel: Bool = true
    var body: some View {
        
            VStack{
                HStack{
                    Text("Time slept")
                    Spacer()
                    Button(action: {
                        wheel.toggle()
                    }, label: {
                        Image(systemName: wheel ? "clock" : "slider.horizontal.3")
                    })
                }
                if(wheel){
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
                    }.frame(width: 325,height: 200)
                } else {
                    SleepCalculatorView(hours: $hours, minutes: $minutes)
                        .frame(width: 325,height: 200)
                }
            }.padding()
        
    }
}

struct TimeSelector_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelector(hours:.constant(0), minutes: .constant(0))
    }
}
