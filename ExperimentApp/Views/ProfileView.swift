//
//  ProfileView.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/21/23.
//

import SwiftUI

struct ProfileView: View {
    @Binding var appData: AppData
    var body: some View {
        NavigationStack{
            Form{
                Section("Finished experiments"){
                    
                    ForEach($appData.sleepExperiments){ $a in
                        NavigationLink(destination: SleepView(experiment: $a)){
                            FinishedExperimentRow(name: a.name, startDate: a.startDate, endDate: a.endDate ?? Date(), medal: a.medal)
                        }
                    }
                    
                    
                    //Add your own
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(appData: .constant(AppData.sampleData))
    }
}
