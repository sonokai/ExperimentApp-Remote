//
//  DayProcedureView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import SwiftUI

struct DayProcedureView: View {
    var body: some View {
        Text("This experiment tests what time of day you're the most productive in. There are three parts of the day: morning, afternoon, and evening. For statistical correctness, use the randomization feature in the app to decide which time of the day you will test for a certain day, but this part is optional. Next, pick the time you want to work for (this needs to be the same for all times of day). Set a timer to work for that long (maybe we can add pomodoro stuff) Then, at the end, assess your productivity on a scale of 1-10. ")
    }
}

struct DayProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        DayProcedureView()
    }
}
