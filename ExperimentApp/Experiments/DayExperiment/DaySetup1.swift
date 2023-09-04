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
                    
                    if(!independentVariable.times.contains(time.rawValue)){
                        Button("Add"){
                            independentVariable.times.append(time.rawValue)
                        }
                    } else {
                        Button("Remove"){
                            if let i = independentVariable.times.firstIndex(of: time.rawValue) {
                                independentVariable.times.remove(at: i)
                            }
                        }
                    }
                    
                }
            }
            .padding(.horizontal)
            .padding(.vertical,1)
            
            Text("(And/or) add custom times:")
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            
            ForEach(independentVariable.customtimes.indices, id: \.self){ index in
                HStack{
                    Text(independentVariable.customtimes[index].name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button("Remove"){
                        independentVariable.customtimes.remove(at: index)
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.vertical,1)
            }
            HStack{
                TextField("Enter custom time: (ex: before bed)", text: $textFieldValue)
                Button(action :{
                    withAnimation{
                        let newCustomTime = DayExperiment.IndependentVariable.customTime(name: textFieldValue)
                        independentVariable.customtimes.append(newCustomTime)
                        textFieldValue = ""
                        
                    }
                }){
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(checkTextValue(text: textFieldValue))
                
            }
            .padding(.horizontal)
            .padding(.vertical,1)
            
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
        for customTime in independentVariable.customtimes{
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
