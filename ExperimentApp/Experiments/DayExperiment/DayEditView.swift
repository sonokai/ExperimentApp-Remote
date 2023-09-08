//
//  DayEditView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct DayEditView: View {
    @Binding var entry: DayEntry
    @State var date: Date = Date()
    @State var time: DayExperiment.Time = .morning
    @State var productivity: Int = 5
    @State private var sliderValue: Double = 5
    @Environment(\.presentationMode) private var presentationMode
    var independentVariable: DayExperiment.IndependentVariable
    var dependentVariable: DayExperiment.DependentVariable
    
    var body: some View {
        NavigationStack{
            Form{
                DatePicker("Entry date", selection: $date, in: ...Date(),displayedComponents: [.date])
                
                TimePicker(selection: $time, independentVariable: DayExperiment.sampleIndependentVariable) //doesnt work yet
                
                SliderView(name:"hi", value: $productivity)
                
                
            }.toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        //update the entry binding when and if the done button is pressed
                        entry.date = date
                        entry.time = ""
                //        entry.productivity = productivity
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct DayEditView_Previews: PreviewProvider {
    static var previews: some View {
        DayEditView(entry:.constant(DayEntry.newEntry), independentVariable: DayExperiment.sampleIndependentVariable, dependentVariable: .focus)
    }
}
