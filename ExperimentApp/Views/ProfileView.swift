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
                    ForEach(appData.finishedExperiments){ finished in
                        NavigationLink(destination: FinishedExperimentView(finishedExperiment: finished)){
                            FinishedExperimentRow(finishedExperiment: finished)
                        }
                    }
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
