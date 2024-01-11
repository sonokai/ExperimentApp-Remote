import SwiftUI
struct MoodSetupView: View {
    
    @StateObject var viewModel = MoodTrackerViewModel()
    @Binding var moodExperiments: [MoodTracker]
    @Binding var appData: AppData
    @State private var shouldNavigate = false
    @State var name: String = ""
    let saveAction : () -> Void
    
    var body: some View {
        NavigationStack {
           Form {
               Text("Let's set up your mood experiment.").font(.headline)
               DurationView(viewModel: viewModel)
               MoodTrackerEntrySetupView(viewModel: viewModel)
               ExperimentNameView(name: $name, defaultValue: "Mood Tracker")
            }
        } .toolbar {
            ToolbarItem(placement: .confirmationAction){
                Button {
                    
                    moodExperiments.append(MoodTracker(name: name, entries: [], duration: viewModel.duration, dailyEntryGoal: viewModel.dailyEntryGoal))
                    shouldNavigate = true
                } label: {
                    Text("Start Tracking")
                }
            }
        }
        NavigationLink(destination: ExperimentView(appData: $appData, saveAction: saveAction), isActive: $shouldNavigate) {
                        EmptyView()
                    }
    }
}
                                           


struct MoodSetupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoodSetupView(moodExperiments: .constant(MoodTracker.sampleExperiments), appData: .constant(AppData.sampleData), saveAction: {})
        }
    }
}


/*struct MoodTrackerTitleView: View {
    
    var imageName: String
    @State private var experimentName = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                
                TextField("Mood Experiment Title", text: $experimentName)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}*/

