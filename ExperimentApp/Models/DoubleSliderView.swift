//
//  DoubleSliderView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/13/23.
//

import SwiftUI

struct DoubleSliderView: View {
    var name: String
    @Binding var value: Double
    @State private var sliderValue: Double = 5
    var lowValue : Double = 1
    var highValue: Double = 10
    
    var decimalPlaces: Double = 2
    
    var body: some View {
        VStack{
            Text(name)
            
            
            
            HStack{
                Slider(value: $sliderValue, in: lowValue...highValue, step: 0.01).onChange(of: sliderValue) { newValue in
                    value = newValue
                }
                let number = String(format: "%.2f", value)
                Text(number)
            }
            
        }
    }
    //Rounds to the appropriate number of decimal place
}

struct DoubleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleSliderView(name: "Value", value: .constant(5))
    }
}
