//
//  CustomDatePicker.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/22/23.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var date: Date
    @Binding var timeSelectorPopOver: Bool
    @State var hours: Int = 0
    @State var hoursSelection: Int = 120
    @State var minutesSelection: Int = 600
    @State var minutes: Int = 0
    @State var ampm: AMPM = .AM
    @Environment(\.presentationMode) private var presentationMode
    
    enum AMPM{
        case AM, PM
    }
    var body: some View {
        VStack{
            Button("Now (\(getFormattedTimeNow()))"){
                setTimeToNow()
                updateDate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        presentationMode.wrappedValue.dismiss()
                }
            }
            HStack(spacing: 0){
                Picker("H", selection: $hoursSelection) {
                    ForEach(1...240, id: \.self) { hour in
                        Text("\((hour-1)%12+1)")
                    }
                }.pickerStyle(.wheel).frame(minWidth: 0)
                    .compositingGroup()
                    .clipped()
                    
                
                Picker("M", selection: $minutesSelection) {
                    
                    ForEach(0...1200, id: \.self) { minute in
                        if(minute%60<10){
                            Text("0\(minute%60)")
                        } else {
                            Text("\(minute%60)")
                        }
                        
                    }
                }.pickerStyle(.wheel)
                    .frame(minWidth: 0)
                    .compositingGroup()
                    .clipped()
                    
                Picker("AMPM", selection: $ampm){
                    Text("AM").tag(AMPM.AM)
                    Text("PM").tag(AMPM.PM)
                }.pickerStyle(.wheel)
                    .frame(minWidth: 0)
                    .compositingGroup()
                    .clipped()
                
            }.onAppear(){
                hoursSelection = getHour()+120
                minutesSelection = getMinute()+600
                ampm = getAMPM()
            }.onDisappear(){
                updateDate()
                timeSelectorPopOver = false
            }
        }.frame(width: 150, height: 200)
    }
    func getHour() -> Int {
        let calendar = Calendar.current
        let hourComponent = calendar.component(.hour, from: date)
        return hourComponent%12
    }
    
    func getMinute() -> Int {
        let calendar = Calendar.current
        let minuteComponent = calendar.component(.minute, from: date)
        return minuteComponent
    }
    
    func getAMPM() -> AMPM {
        let calendar = Calendar.current
        let hourComponent = calendar.component(.hour, from: date)
        return hourComponent < 12 ? .AM : .PM
    }
    func getFormattedTimeNow() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: Date())
    }
    func setTimeToNow(){
        let calendar = Calendar.current
        let hourComponent = calendar.component(.hour, from: Date())
        let minuteComponent = calendar.component(.minute, from: Date())
        
        hoursSelection = hourComponent+120
        minutesSelection = minuteComponent+600
        ampm = hourComponent<12 ? .AM : .PM
    }
    func updateDate(){
        hours = hoursSelection % 12 + (ampm == .PM && (hoursSelection%12) != 12 ? 12 : 0)
        minutes = minutesSelection % 60
        
        var dateComponents = DateComponents()
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = 0
        
        let calendar = Calendar.current
        if let newdate = calendar.date(from: dateComponents){
            date = newdate
        }
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            
            CustomDatePicker(date: .constant(Date()), timeSelectorPopOver: .constant(false))
        }
    }
}
