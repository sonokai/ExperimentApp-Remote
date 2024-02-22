import Foundation

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    var rating: Int
    var date: Date
    var time: Date
    var insights: String
    var timeOfDay: TimeOfDay
    
    
    
    
    init(id: UUID = UUID(), rating: Int, date: Date,  time: Date, insights: String) {
        self.id = id
        self.rating = rating
        self.date = date
        self.time = time
        self.insights = insights
        
        let calendar = Calendar.current
            let components = calendar.dateComponents([.hour], from: time)

            if let hour = components.hour {
                switch hour {
                case 5..<12:
                    timeOfDay = .morning
                case 12..<17:
                    timeOfDay = .afternoon
                case 17..<21:
                    timeOfDay = .evening
                default:
                    timeOfDay = .night
                }
            } else {
                timeOfDay = .night
            }
        
    }
    
    /*init(newEntry: NewMoodEntry) {
        self.id = UUID()
        self.rating = newEntry.rating
        self.date = newEntry.date
        self.time = newEntry.time
        self.insights = newEntry.insights
        self.timeOfDay = newEntry.timeOfDay
    }
    */
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
    
    static func createDate(month: Int, day: Int, year: Int) -> Date? {
            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day

            let calendar = Calendar.current
            return calendar.date(from: dateComponents)
        }
    
    static func createTime(hour: Int, minute: Int) -> Date{
            return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
        }
    
    
    static let sampleData: [MoodEntry] =
    [
        MoodEntry(rating: 3, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 6, minute: 30), insights: "Just got out of a stressful meeting."),
        
        MoodEntry(rating: 7, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 7, minute: 27), insights: "Got home from work"),
        
        MoodEntry(rating: 9, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 8, minute: 30), insights: "Saw my family"),
        
        MoodEntry(rating: 4, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 9, minute: 45), insights: "dont listen to french montana"),
        
        MoodEntry(rating: 8, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 10, minute: 0), insights: "meow"),
        
        MoodEntry(rating: 9, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 11, minute: 36), insights: "nice girthy thick burrito in my mouth rn"),
        
        MoodEntry(rating: 3, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 11, minute: 38), insights: "stop talking brenda"),
        
        MoodEntry(rating: 10, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 12, minute: 30), insights: "robbed a bank"),
        
        MoodEntry(rating: 4, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 13, minute: 30), insights: "no milk"),
        
        MoodEntry(rating: 2, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 14, minute: 30), insights: "opened instagram"),
        
        MoodEntry(rating: 9, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 14, minute: 32), insights: "framed someone"),
        
        MoodEntry(rating: 5, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 15, minute: 15), insights: "brother fell down the stairs"),
        
        MoodEntry(rating: 9, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 16, minute: 30), insights: "victory royale in fortnite"),
        
        MoodEntry(rating: 10, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 18, minute: 39), insights: "grandma died"),
        
        MoodEntry(rating: 3, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 19, minute: 30), insights: "got shot"),
        
        MoodEntry(rating: 4, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 20, minute: 30), insights: "gatorade was bad"),
        
        MoodEntry(rating: 10, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 20, minute: 31), insights: "HAHAHAHAH"),
        
        MoodEntry(rating: 3, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 20, minute: 2), insights: "i love coding"),
        
        MoodEntry(rating: 10, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 20, minute: 40), insights: "cheeseburger"),
        
        MoodEntry(rating: 3, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 22, minute: 30), insights: "no hamburger"),
        
        MoodEntry(rating: 10, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 23, minute: 30), insights: "hamburger"),
        
        MoodEntry(rating: 1, date: (createDate(month: 1, day: 1, year: 2024))!, time: createTime(hour: 23, minute: 3), insights: "midterm"),
        
        MoodEntry(rating: 6, date: (createDate(month: 1, day: 2, year: 2024))!, time: createTime(hour: 1, minute: 37), insights: ""),
        
        MoodEntry(rating: 6, date: (createDate(month: 1, day: 2, year: 2024))!, time: createTime(hour: 2, minute: 28), insights: "mid"),
        
        MoodEntry(rating: 6, date: (createDate(month: 1, day: 2, year: 2024))!, time: createTime(hour: 3, minute: 45), insights: "ate noodle")
        
        
        
    
    ]
    
    static var newEntry : MoodEntry{
        MoodEntry(rating: 5, date: Date(), time: Date(), insights: "Tired")
    }
    
}

extension MoodEntry {
    enum TimeOfDay: String, Codable, Identifiable, CaseIterable {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case evening = "Evening"
        case night = "Night"
        
        var id: Self {
            return self
        }
    }
}
