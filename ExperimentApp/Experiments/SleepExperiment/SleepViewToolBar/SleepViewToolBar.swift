//
//  SleepViewToolBar.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/25/23.
//

import SwiftUI

extension SleepView{
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent{
        ToolbarItemGroup(placement:.navigationBarLeading){
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
            })
            SleepHistoryButton(experiment: $experiment)
        }
        ToolbarItem(placement: .principal){
            Text(experiment.name).font(.headline)
        }
        ToolbarItemGroup(placement: .navigationBarTrailing){
            SleepEntryButton(experiment: $experiment)
            NewSleepInsightButton(experiment: $experiment)
            
        }
        
    }
}
