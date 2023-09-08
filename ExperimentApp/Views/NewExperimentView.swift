//
//  NewExperimentView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/27/23.
//

import SwiftUI

struct NewExperimentView: View {
    @Binding var appData: AppData
    @Binding var isPresentingSheetView : Bool
    var body: some View {
        
        NavigationStack{
            Form{
                Section(header: Text("Experiments")){
                    NavigationLink(destination: SleepIntroView(sleepExperiments: $appData.sleepExperiments, isPresentingSheetView: $isPresentingSheetView)){
                        Text("Start a sleep experiment")
                    }
                    NavigationLink(destination: DaySetupView(dayExperiments: $appData.dayExperiments, isPresentingSheetView: $isPresentingSheetView)){
                        Text("Start a day experiment")
                    }
                    NavigationLink(destination: MoodSetupView(moodExperiments: $appData.moodExperiments)){
                        Text("Start a mood experiment")
                    }
                }
            }
        }
    }
}

struct NewExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        NewExperimentView(appData: .constant(AppData.sampleData), isPresentingSheetView: .constant(true))
    }
}
