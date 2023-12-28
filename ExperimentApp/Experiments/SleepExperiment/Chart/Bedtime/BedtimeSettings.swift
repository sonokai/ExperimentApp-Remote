//
//  BedtimeRangeEditor.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/27/23.
//

import SwiftUI

struct BedtimeSettings: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @State var errorMessage: String = ""
    @Environment(\.presentationMode) var presentationMode
    //these will serve as temporary, only update the bindings if it is valid
    @State var start: Date = Date()
    @State var end: Date = Date()
    
    @Binding var entriesRequired: Int
    
    var body: some View {
        NavigationStack{
            Form{
                Section("X axis endpoints"){
                    DatePicker("Lower endpoint", selection: $start, displayedComponents: .hourAndMinute)
                    DatePicker("Upper endpoint", selection: $end, displayedComponents: .hourAndMinute)
                    Button(action: {
                        startDate = start.formatDateForChart()
                        endDate = end.formatDateForChart()
                    }, label: {
                        Text("Save")
                    }).disabled(!isValidEndpoints())
                    
                    if(!isValidEndpoints()){
                        Text(errorMessage).onAppear(){
                            let _ = isValidEndpoints()
                        }
                    }
                }
                Section("Optimal interval"){
                    SliderView(name: "Entries required", value: $entriesRequired, lowValue: 1, highValue: 10)
                }
            }.navigationTitle("Chart settings")
                .onAppear(){
                    start = startDate
                    end = endDate
                }.buttonStyle(.borderless)
                .toolbar(){
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Done"){
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }
    }
    func isValidEndpoints() ->Bool{
        let start1 = start.formatDateForChart()
        let end1 = end.formatDateForChart()
        
        if(differenceBetweenDates(date1: start1, date2: end1) < 1800){
            //if an am time is being compared to a pm time
            if(!isPM(start1) && isPM(end1)){
                errorMessage = "In the context of bedtimes, PM is part of the first day and AM is part of the second day. Your lower endpoint must be earlier than your higher endpoint."
                return false
            }
            //if the end is less than 30 minutes later than the start
            errorMessage = "Your upper endpoint must be at least 30 minutes later than your lower endpoint"
            return false
        }
        return true
    }
    func differenceBetweenDates(date1: Date, date2: Date) -> TimeInterval {
        let timeInterval = date2.timeIntervalSince(date1)
        return timeInterval
    }
    func isPM(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        let ampmIndicator = dateFormatter.string(from: date)
        return ampmIndicator.lowercased() == "pm"
    }
}

struct BedtimeRangeEditor_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeSettings(
            startDate: .constant(Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!),
            endDate: .constant(Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!),
            entriesRequired: .constant(0)
        )
    }
}
