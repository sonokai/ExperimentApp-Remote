//
//  SleepView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/19/23.
//
// state the question as a title, present nav link to another view which edits the results of each day (independent and dependent variable), then at the bottom of the screen, once enough data is collected, it displays results and confidence
import SwiftUI
//for now, we just set arbitrary numbers to these, but later we'll make them editable
//probably use a dictionary for results
struct SleepView: View {
    var trials : Int
    @Binding var entries: [IntEntry]
    @State private var independent: String = ""
    @State private var dependent: String = ""
    @State private var date: String = ""
    
    
    var body: some View {
        VStack{
            Text("Does the amount of sleep I get affect the quality of my day?").font(.headline).padding(4)
            
            VStack {
                HStack{
                    Text("Add new entry")
                    Spacer()
                    Button(action: {
                        withAnimation {
                            let entry = IntEntry(date: date, independent: 1, dependent: 1)
                            entries.append(entry)
                            date = ""
                            dependent = ""
                            independent = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add new entry")
                    }
                    .disabled(date.isEmpty || dependent.isEmpty || independent.isEmpty)
                    
                }
                TextField("Entry date:", text: $date)
                TextField("Hours of sleep:", text: $independent)
                TextField("Quality of day:", text: $dependent)
                
            }
            .padding()
            
            
            List($entries){ entry in
                IntEntryView(independentName: "Hours slept", dependentName: "Quality of day", entry:entry)
            }
            
            
        }
        
        
    }
}

struct SleepView_Previews: PreviewProvider {
    static var previews: some View {
        SleepView(trials: 5, entries: .constant(IntEntry.sampleData))
    }
}
