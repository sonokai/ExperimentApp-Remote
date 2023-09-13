//
//  DaySetup1.swift
//  ExperimentApp
//
//  Created by Bell Chen on 9/2/23.
//

import SwiftUI

struct DaySetup1: View {
    @Binding var independentVariable: DayExperiment.IndependentVariable
    @State var textFieldValue: String = ""
    let defaultTimes: Set<String> = ["Morning, Afternoon, Evening"]
    var body: some View {
        VStack{
            Text("Choose parts of the day to track:")
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            
            ForEach(DayExperiment.Time.allCases){ time in
                HStack{
                    Text(time.rawValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //if we don't have the time in our array, display "Add", otherwise, display "Remove"
                    if(!independentVariable.containsTime(time:time.rawValue)){
                        Button("Add"){
                            let newTime = DayExperiment.IndependentVariable.timeOfDay(name: time.rawValue)
                            independentVariable.timesOfDay.append(newTime)
                        }
                    } else {
                        Button("Remove"){
                            independentVariable.removeTime(time: time.rawValue)
                        }
                    }
                    
                }
            }
            .padding(1)
            
            Text("And/or add custom times:")
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            
            ForEach(independentVariable.timesOfDay.indices, id: \.self){ index in
                //As long as the time of day isn't found in the default times, display it
                if(!independentVariable.findIndexesToAvoid().contains(index)){
                    HStack{
                        Text(independentVariable.timesOfDay[index].name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button("Remove"){
                            independentVariable.timesOfDay.remove(at: index)
                        }
                        
                    }
                    .padding(1)
                }
            }
            HStack{
                TextField("Enter custom time: (ex: before bed)", text: $textFieldValue)
                Button(action :{
                    withAnimation{
                        let newTime = DayExperiment.IndependentVariable.timeOfDay(name: textFieldValue)
                        independentVariable.timesOfDay.append(newTime)
                        textFieldValue = ""
                        
                    }
                }){
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(checkTextValue(text: textFieldValue))
                
            }
            .padding(1)
            
        }.buttonStyle(.borderless)
    }
    
    func checkTextValue(text: String) -> Bool{
        if(text == ""){
            return true
        }
        if(text == "Afternoon" || text == "Evening" || text == "Morning"){
            return true
        }
        var customTimesArray: [String] = []
        for customTime in independentVariable.timesOfDay{
            customTimesArray.append(customTime.name)
        }
        if(customTimesArray.contains(text)){
            return true
        }
        return false
    }
}

struct DaySetup1_Previews: PreviewProvider {
    static var previews: some View {
        DaySetup1(independentVariable: .constant(DayExperiment.sampleIndependentVariable))
    }
}
