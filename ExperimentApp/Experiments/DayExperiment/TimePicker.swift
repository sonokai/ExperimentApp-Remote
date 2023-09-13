//
//  TimePicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct TimePicker: View {
    @Binding var selection: String
    var independentVariable: DayExperiment.IndependentVariable
    var body: some View {
        
        Picker("Time",selection:$selection){
            /*
            ForEach(DayExperiment.Time.allCases){time in
                if(timeIsInArray(time: time)){
                    Text(time.rawValue)
                        .padding(4)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }
             */
            ForEach(independentVariable.timesOfDay){time in
                Text(time.name)
                    .tag(time.name)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            
            
            
        }
        .pickerStyle(.automatic)
    }
    /*
    func timeIsInArray(time: DayExperiment.Time) -> Bool{
        for timeInArray in independentVariable.aHHHHHNEEDTOFIX{
            if(timeInArray == time.rawValue){
                print("The independent variable contains \(time.rawValue)")
                return true
                
            }
        }
        if(independentVariable.aHHHHHNEEDTOFIX.contains(time.rawValue)){
           
            return true
        }
        return false
    }
     */
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(selection: .constant("Afternoon"), independentVariable: DayExperiment.sampleIndependentVariable)
    }
}
