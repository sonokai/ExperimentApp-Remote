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
    @State var time: String = "Morning"
    @State var focus: Int = 5
    @State var plannedToDoneRatio: Double = 1
    @State var minutesWorked: Int = 30
    
    @Environment(\.presentationMode) private var presentationMode
    var independentVariable: DayExperiment.IndependentVariable
    var dependentVariable: DayExperiment.DependentVariable
    
    var body: some View {
        NavigationStack{
            Form{
                DatePicker("Entry date", selection: $date, in: ...Date(),displayedComponents: [.date])
                
                TimePicker(selection: $time, independentVariable: DayExperiment.sampleIndependentVariable)
                
                switch(dependentVariable){
                case .focus:
                    SliderView(name: "Focus", value: $focus)
                case .plannedToDoneRatio:
                    DoubleSliderView(name: "Planned to done ratio", value: $plannedToDoneRatio, lowValue: 0.1, highValue: 3)
                case .time:
                    SliderView(name: "Time worked", value: $minutesWorked, lowValue: 10, highValue: 200)
                }
                
                
            }.toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        
                        entry.date = date
                        entry.time = ""
                        switch(dependentVariable){
                        case .focus:
                            entry.focus = focus
                        case .plannedToDoneRatio:
                            entry.plannedToDoneRatio = plannedToDoneRatio
                        case .time:
                            entry.minutesWorked = minutesWorked
                        }
                //update everything
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct DayEditView_Previews: PreviewProvider {
    static var previews: some View {
        DayEditView(entry:.constant(DayEntry.newEntry), independentVariable: DayExperiment.sampleIndependentVariable, dependentVariable: .plannedToDoneRatio)
    }
}
