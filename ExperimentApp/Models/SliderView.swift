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
    var lowValue : Double = 1
    var highValue: Double = 10
    
    
    var body: some View {
        if(lowValue >= highValue){
            Text("Slider unavailable when range is too low")
        } else {
            VStack{
                Text(name)
                HStack{
                    Slider(value: $sliderValue, in: lowValue...highValue, step: 0.01).onChange(of: sliderValue) { newValue in
                        value = Int(newValue)
                    }
                    Text("\(value)")
                }
            }
        }
    }
    

}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(name: "productivity", value: .constant(5))
    }
}
