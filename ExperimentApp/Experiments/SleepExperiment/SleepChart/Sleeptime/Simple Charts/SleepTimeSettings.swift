//
//  SleepTimeSettings.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/28/23.
//

import SwiftUI

struct SleepTimeSettings: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @State var errorMessage: String = ""
    @Environment(\.presentationMode) var presentationMode
    //these will serve as temporary, only update the bindings if it is valid
    @State var start: Int = 0
    @State var end: Int = 0
    @State var startHours: Int = 0
    @State var startMinutes: Int = 0
    @State var endHours: Int = 0
    @State var endMinutes: Int = 0
    
    @Binding var entriesRequired: Int
    
    var body: some View {
        NavigationStack{
            Form{
                Section("X axis endpoints"){
                    Text("Lower endpoint")
                    HStack{
                        Picker("Hours", selection: $startHours) {
                            ForEach(0...23, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }.pickerStyle(.wheel).onChange(of: startHours){ _ in
                            calculateStart()
                        }
                        Text("Hours")
                        Picker("Minutes", selection: $startMinutes) {
                            
                            ForEach(0...59, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }.pickerStyle(.wheel).onChange(of: startMinutes){ _ in
                            calculateStart()
                        }
                        Text("minutes")
                        Spacer()
                    }.frame(width: 325,height: 170)

                    Text("Upper endpoint")
                    HStack{
                        Picker("Hours", selection: $endHours) {
                            ForEach(0...23, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }.pickerStyle(.wheel).onChange(of: endHours){ _ in
                            calculateEnd()
                        }
                        Text("Hours")
                        Picker("Minutes", selection: $endMinutes) {
                            
                            ForEach(0...59, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }.pickerStyle(.wheel).onChange(of: endMinutes){ _ in
                            calculateEnd()
                        }
                        Text("minutes")
                        Spacer()
                    }.frame(width: 325,height: 170)
                    Button(action: {
                        startDate = formatTime(hour: startHours, minute: startMinutes)
                        endDate = formatTime(hour: endHours, minute: endMinutes)
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
                    let calendar = Calendar.current
                    let startcomponents = calendar.dateComponents([.hour, .minute], from: startDate)
                    if let hour = startcomponents.hour, let minute = startcomponents.minute {
                        startHours = hour
                        startMinutes = minute
                    }
                    let endComponents = calendar.dateComponents([.hour, .minute], from: endDate)
                    if let hour = endComponents.hour, let minute = endComponents.minute {
                        endHours = hour
                        endMinutes = minute
                    }
                    calculateStart()
                    calculateEnd()
                    
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
    func calculateStart(){
        start = startHours * 60 + startMinutes
    }
    func calculateEnd(){
        end = endHours * 60 + endMinutes
    }
    func convertDate(hour: Int, minute: Int) -> Date?{
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        return Calendar.current.date(from: dateComponents)
        
    }
    func formatTime(hour: Int, minute: Int) -> Date {
        if let date = convertDate(hour: hour, minute: minute) {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH:mm"
            let dateString = dateformatter.string(from: date)
            let newDate = dateformatter.date(from: dateString)

            return newDate!
        } else {
            print("Uh oh")
            return Date()
        }
    }
    
    func isValidEndpoints() ->Bool{
        if(end-start<30){
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
}

struct SleepTimeSettings_Previews: PreviewProvider {
    static var previews: some View {
        SleepTimeSettings(startDate: .constant(Date()), endDate: .constant(Date()), entriesRequired: .constant(0))
    }
}
