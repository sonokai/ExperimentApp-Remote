//
//  SleepProcedureView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/26/23.
//

import SwiftUI

struct SleepProcedureView: View {
    var body: some View {
        VStack{
            Text("Every day before you sleep, log in the experiment app when you go to bed. \nThe next day, log when you wake up. \nAt the end of the day, rate the quality of your day on a scale of 1-10.").padding(4)
        
        }.padding(10)
    }
}

struct SleepProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        SleepProcedureView()
    }
}
