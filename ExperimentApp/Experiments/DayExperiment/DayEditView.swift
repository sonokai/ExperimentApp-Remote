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
    @State var productivity: Int = 5
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
                    SliderView(name: "Focus", value: $productivity)
                case .plannedToDoneRatio:
                    Text("ratio picker")
                case .time:
                    Text("time")
                }
                
                
            }.toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        
                        entry.date = date
                        entry.time = ""
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
        DayEditView(entry:.constant(DayEntry.newEntry), independentVariable: DayExperiment.sampleIndependentVariable, dependentVariable: .focus)
    }
}
