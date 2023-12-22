//
//  SleepCalculatorView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct SleepCalculatorView: View {
    
    @State var bedtime: Date = Calendar.current.startOfDay(for: Date())
    @State var waketime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
    @Binding var hours: Int
    @Binding var minutes: Int
    var body: some View {
        VStack{
            DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.hourAndMinute])
            DatePicker("Wake time", selection: $waketime, displayedComponents: [.hourAndMinute])
            HStack{
                Text("Time slept: ")
                Spacer()
                Text(SleepEntry.calculateTimeSlept(sleep: bedtime, wake: waketime))
            }.onChange(of: bedtime){ _ in
                let (newhours, newminutes) = SleepEntry.returnTimeSlept(sleep: bedtime, wake: waketime)
                hours = newhours
                minutes = newminutes
            }.onChange(of: waketime){ _ in
                let (newhours, newminutes) = SleepEntry.returnTimeSlept(sleep: bedtime, wake: waketime)
                hours = newhours
                minutes = newminutes
            }
            
        }
    }
    
}

struct SleepCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        SleepCalculatorView(hours: .constant(0), minutes: .constant(0))
    }
}
