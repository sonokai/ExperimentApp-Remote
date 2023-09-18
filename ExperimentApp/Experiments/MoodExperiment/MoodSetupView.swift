import SwiftUI
struct MoodSetupView: View {
    
    @Binding var moodExperiments: [MoodExperiment]
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var duration: Int = 0
    @State private var notificationInterval: Int = 2
    
    let intervals = [1, 2, 3, 4, 5]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(alignment: .center) {
                    Spacer()
                    
                    Form {
                        Text("Let's set up your mood experiment.")
                        DatePicker("Start Date", selection: $startDate, in: Date()..., displayedComponents: [.date])
                            .onChange(of: startDate) { _ in
                                updateDuration()
                            }
                        DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date])
                            .onChange(of: endDate) { _ in
                                updateDuration()
                            }
                        HStack {
                            Text("Duration:")
                            Spacer()
                            Text(String(duration))
                            Text("Days")
                        }
                        HStack {
                            Picker("Notification Interval", selection: $notificationInterval) {
                                ForEach(intervals, id: \.self) { number in
                                    Text("\(number)")
                                }
                            }
                            Text("Hours")
                        }
                    }
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
        private func updateDuration() -> Void {
            let date1 = startDate
            let date2 = endDate
            
            let timeInterval = date2.timeIntervalSince(date1)
            
            let days = Int(round(timeInterval / (60 * 60 * 24)))
            
            duration = days
        }
    
    
    
    struct MoodSetupView_Previews: PreviewProvider {
        static var previews: some View {
            MoodSetupView(moodExperiments: .constant(MoodExperiment.sampleExperiments))
        }
    }
}
