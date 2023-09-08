import Foundation

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    var date: Date
    let rating: Int
    
    private var moodEntries: [MoodEntry] = []
    
    init(id: UUID = UUID(), date: Date, rating: Int) {
        self.id = id
        self.date = date
        self.rating = rating
    }
    
    func getHour(date: Date) -> (Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        guard let hour = components.hour else {
            fatalError("Failed to extract")
        }
        return hour
    }
    func getMinute(date: Date) -> (Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date)
        guard let minute = components.minute else {
            fatalError("Failed to extract")
        }
        return minute
        
    }
    
    
    
    
    
}

extension MoodEntry {
    static let sampleData: [MoodEntry] =
    [
        MoodEntry(
            date: Date(),
            rating: 5
            ),
        
        MoodEntry(
            date: Date(),
            rating: 6
            ),
        
        MoodEntry(
            date: Date(),
            rating: 8
            )
    
    ]
    
}
