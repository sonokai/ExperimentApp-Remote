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
        ToolbarItemGroup(placement: .navigationBarTrailing){
            SleepEntryButton(experiment: $experiment)
            NewSleepInsightButton(experiment: $experiment)
            SleepHistoryButton(experiment: $experiment)
        }
    }
}
