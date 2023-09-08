//
//  DaySetup3.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/7/23.
//

import SwiftUI

struct DaySetup3: View {
    @State var sliderValue: Double = 20
    @Binding var goalEntries: Int
    
    var body: some View {
        VStack{
            
            Text("Choose a goal amount of entries.")
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text("The more entries you have, the more your results can conclude.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            Text("5+ entries: A general idea of how much time of day affects your work")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            Text("20+ entries: Statistical significance")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            Text("30+ entries: Make conclusions about what time of day you should work")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            
            //review the statistics behind this
            HStack{
                Slider(value: $sliderValue, in: 5...40, step: 0.1).onChange(of: sliderValue) { newValue in
                    goalEntries = Int(newValue)
                }
                Text("\(goalEntries)")
            }
            
        }
        
    }
}

struct DaySetup3_Previews: PreviewProvider {
    static var previews: some View {
        DaySetup3(goalEntries: .constant(1))
    }
}
