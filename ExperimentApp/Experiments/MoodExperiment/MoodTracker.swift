// Tracks mood fluctuations and makes time vs mood graph, so users can use this data to improve their lives.

import Foundation

struct MoodTracker: Identifiable, Codable {
    let id: UUID
    let duration: Int // ask user how many days they want the experiment to last.
    let dailyEntryGoal: Int
    var entries: [MoodEntry] = []
    var name: String = "Mood Tracker"
 
    init(id: UUID = UUID(), name: String, entries: [MoodEntry], duration: Int,  dailyEntryGoal: Int) {
        self.id = id
        self.entries = entries
        self.name = name
        self.duration = duration
        self.dailyEntryGoal = dailyEntryGoal
    }
}
extension MoodTracker{
    static let sampleExperiment1: MoodTracker = MoodTracker(name: "Mood Experiment", entries: MoodEntry.sampleData, duration: 40,  dailyEntryGoal: 5)
    
    static let sampleExperiments: [MoodTracker] = [
    sampleExperiment1
    ]
}
