//
//  SliderView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/30/23.
//

import SwiftUI

struct SliderView: View {
    var name: String
    @Binding var value: Int
    @State private var sliderValue: Double = 5
    
    var body: some View {
        VStack{
            Text(name)
            HStack{
                Slider(value: $sliderValue, in: 1...10, step: 0.1).onChange(of: sliderValue) { newValue in
                    value = Int(newValue)
                }
                Text("\(value)")
            }
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(name: "productivity", value: .constant(5))
    }
}
