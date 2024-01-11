//
//  DurationView.swift
//  ExperimentApp
//
//  Created by Kai Green on 1/9/24.
//

import SwiftUI

struct DurationView: View {
    
    @ObservedObject var viewModel: MoodTrackerViewModel
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Choose how long you'd like to track your mood.").font(.headline)
                DatePicker("Start Date:", selection: $startDate, in: Date()..., displayedComponents: [.date])
                    .onChange(of: startDate) { _ in
                        updateDuration()
                }
                DatePicker("End Date:", selection: $endDate, in: startDate..., displayedComponents: [.date])
                    .onChange(of: endDate) { _ in
                        updateDuration()
                }
                HStack {
                    Text("Duration:")
                    Spacer()
                    Text("\(viewModel.duration) Days")
                }
            }
        }
    }
    
    
    private func updateDuration() -> Void {
        let date1 = startDate
        let date2 = endDate
        
        let timeInterval = date2.timeIntervalSince(date1)
        
        let days = Int(round(timeInterval / (60 * 60 * 24)))
        
        viewModel.duration = days
    }
}
struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView(viewModel: MoodTrackerViewModel())
    }
}
