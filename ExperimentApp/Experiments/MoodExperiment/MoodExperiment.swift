// Tracks mood fluctuations and makes time vs mood graph, so users can use this data to improve their lives.

import Foundation

struct MoodExperiment: Identifiable, Codable {
    let id: UUID
    let duration: Int // ask user how many days they want the experiment to last.
    var entries: [MoodEntry] = []
    var name: String = "Mood Experiment"
 
    init(id: UUID = UUID(), duration: Int, entries: [MoodEntry], name: String) {
        self.id = id
        self.duration = duration
        self.entries = entries
        self.name = name
    }
}

