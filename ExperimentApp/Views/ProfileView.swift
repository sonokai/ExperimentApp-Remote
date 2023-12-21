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
        Text("Profile here")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(appData: .constant(AppData.sampleData))
    }
}
