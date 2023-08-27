//
//  ExperimentView2.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/27/23.
//

import SwiftUI

struct ExperimentView2: View {
    @Environment (\.scenePhase) private var scenePhase
    let saveAction : () -> Void
    @Binding var appData: AppData
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ExperimentView2_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView2(saveAction: {}, appData: .constant(AppData.emptyData))
    }
}
