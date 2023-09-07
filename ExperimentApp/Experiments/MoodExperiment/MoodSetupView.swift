//
//  MoodSetupView.swift
//  ExperimentApp
//
//  Created by Kai Green on 9/7/23.
//

import SwiftUI

struct MoodSetupView: View {
    
    @State private var tempDate = Date()
    
    var body: some View {
        NavigationStack{
            Form{
                Text("Let's set up your mood experiment.")
                DatePicker("Start Date", selection: $tempDate, in: Date()...,displayedComponents: [.date])
                DatePicker("End Date", selection: $tempDate, in: Date()...,displayedComponents: [.date])
                
                
            }
        }
    }
}

struct MoodSetupView_Previews: PreviewProvider {
    static var previews: some View {
        MoodSetupView()
    }
}
