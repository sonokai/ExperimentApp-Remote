import Foundation
import SwiftUI

class MoodTrackerViewModel: ObservableObject {
    @Published var duration: Int = 0
    @Published var dailyEntryGoal: Int = 4
    
}

