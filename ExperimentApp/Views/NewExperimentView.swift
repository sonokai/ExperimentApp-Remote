//
//  NewExperimentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/27/23.
//

import SwiftUI

struct NewExperimentView: View {
    @Binding var appData: AppData
    
    @Binding var selectedTabIndex: Int
    var body: some View {
        
        NavigationStack{
            Form{
                Section(header: Text("Experiments")){
                    NavigationLink(destination: SleepIntroView2(sleepExperiments: $appData.sleepExperiments, selectedTabIndex: $selectedTabIndex)){
                        Text("Start a sleep experiment")
                    }
                    /*
                    NavigationLink(destination: DaySetupView(dayExperiments: $appData.dayExperiments)){
                        Text("Start a day experiment")
                    }
                    NavigationLink(destination: MoodSetupView(moodExperiments: $appData.moodExperiments, appData: .constant(AppData.sampleData), saveAction: {}, selectedTabIndex: $selectedTabIndex)){
                        Text("Start a mood experiment")
                    }
                     */
                }
            }.navigationTitle("Explore experiments")
        }
    }
}

struct NewExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        NewExperimentView(appData: .constant(AppData.sampleData), selectedTabIndex: .constant(0))
    }
}
