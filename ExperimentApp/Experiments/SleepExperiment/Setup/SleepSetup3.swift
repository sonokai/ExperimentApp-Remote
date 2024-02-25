//
//  SleepConfig3.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
//

import SwiftUI

struct SleepSetup3: View {
    @State var sliderValue: Double = 25
    @Binding var goalEntries: Int
    @Binding var index: Int
    
    
    
    
    var body: some View {
        VStack(alignment:.leading){
            Text("Entry goal").font(.largeTitle).bold()
            Text("Choose a goal amount of entries.")
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text("The more entries you have, the more helpful your data will be for optimizing your sleeping patterns.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            HStack{
                Image(systemName: "medal.fill").foregroundColor(.brown)
                Text("15+ entries: Gain a general idea of how much sleep affects your day")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .padding(1)
            }
            HStack{
                Image(systemName: "medal.fill").foregroundColor(.gray)
                Text("25+ entries: Gain a good idea of what happens when you sleep differently")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .padding(1)
            }
            HStack{
                Image(systemName: "medal.fill").foregroundColor(.yellow)
                Text("50+ entries: Make a detailed analysis of what the best habits for your sleep are")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .padding(1)
            }
            //review the statistics behind this
            HStack{
                Slider(value: $sliderValue, in: 5...100, step: 0.1).onChange(of: sliderValue) { newValue in
                    goalEntries = Int(newValue)
                    
                }
                Text("\(goalEntries)")
            }
            Spacer()
            HStack{
                Button("Back"){
                    withAnimation{
                        index = 3
                    }
                }
                Spacer()
                Button("Next"){
                    withAnimation{
                        index = 5
                    }
                }
            }
        }.padding()
        
    }
}

struct SleepConfig3_Previews: PreviewProvider {
    static var previews: some View {
        SleepSetup3(goalEntries: .constant(20), index: .constant(0))
    }
}
