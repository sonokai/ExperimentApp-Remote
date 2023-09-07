import Foundation

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var mood: Int
    
    init(id: UUID = UUID(), date: Date, mood: Int) {
        self.id = id
        self.date = date
        self.mood = mood
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
