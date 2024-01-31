import Foundation

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    let rating: Int
    var date: Date
    var time: Date
    var insights: String
    
    
    
    init(id: UUID = UUID(), rating: Int, date: Date,  time: Date, insights: String) {
        self.id = id
        self.rating = rating
        self.date = date
        self.time = time
        self.insights = insights
        
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
    func createDate(month: Int, day: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
    
    
    
    
    
}

extension MoodEntry {
    
    
    static let sampleData: [MoodEntry] =
    [
        MoodEntry(rating: 3, date: Date(), time: Date(), insights: "Just got out of a stressful meeting."),
        
        MoodEntry(rating: 7, date: Date(), time: Date(), insights: "Got home from work"),
        
        MoodEntry(rating: 9, date: Date(), time: Date(), insights: "Saw my family")
    
    ]
    
}
