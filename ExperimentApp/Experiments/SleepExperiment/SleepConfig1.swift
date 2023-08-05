//
//  SleepConfig1.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/4/23.
//

import SwiftUI

struct SleepConfig1: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("Firstly, choose how you'd like to track your sleep")
                
                //make choice view to make this better
                NavigationLink(destination: SleepConfig2(independentConfig: .bedtime)){
                    Text("Bedtime")
                }
                NavigationLink(destination: SleepConfig2(independentConfig: .waketime)){
                    Text("Waketime")
                }
                NavigationLink(destination: SleepConfig2(independentConfig: .both)){
                    Text("Both bedtime and waketime")
                }
                NavigationLink(destination: SleepConfig2(independentConfig: .hoursSlept)){
                    Text("Hours of sleep")
                }
                ProgressView(value: 1, total: 3)
                Text("Page 1/3")
            }
        }
    }
}

struct SleepConfig1_Previews: PreviewProvider {
    static var previews: some View {
        SleepConfig1()
    }
}
