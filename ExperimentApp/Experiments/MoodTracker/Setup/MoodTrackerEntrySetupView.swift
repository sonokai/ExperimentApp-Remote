//
//  MoodTrackerEntrySetupView.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/9/24.
//

import SwiftUI

struct MoodTrackerEntrySetupView: View {
    
    @ObservedObject var viewModel: MoodTrackerViewModel
    @State var sliderValue: Double = 4
    
    var body: some View {
        VStack {
            Text("Choose how many entries you would like to make per day.")
                .padding(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text("The more entries you have, the more your results can conclude.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            Text("1-2 entries: burrito")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            Text("2-5 entries: chicken tender")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            Text("5-10 entries: burger")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .padding(1)
            HStack{
                Slider(value: $sliderValue, in: 1...10, step: 1).onChange(of: sliderValue) { newValue in
                    viewModel.dailyEntryGoal = Int(newValue)
                }
                Text("\(viewModel.dailyEntryGoal)")
            }
            HStack {
                Text("Total:")
                Spacer()
                Text("\(totalEntries()) Entries")
            }
            
        }
    }
    func totalEntries() -> Int {
        return viewModel.dailyEntryGoal * viewModel.duration
    }
}



struct MoodTrackerEntrySetupView_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackerEntrySetupView(viewModel: MoodTrackerViewModel())
    }
}
