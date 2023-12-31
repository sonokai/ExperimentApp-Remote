//
//  ChartFunctions.swift
//  ExperimentApp
//
//  Created by Bell Chen on 11/13/23.
//

import Foundation

extension Date{
    func simplifyDateToTimeString() -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:mm a"
        let dateString = dateformatter.string(from: self)
        return dateString
    }
    func simplifyDateToHMM() -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "h:mm"
        let dateString = dateformatter.string(from: self)
        return dateString
    }
    func getAMPM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: self)
    }
    func formatDateForChart() -> Date{
        let day = self.getAMPM() == "PM" ? 0 : 1
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        // Extract the time components
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        
        // Create a new date with the specified day and the extracted time components
        if let newDate = calendar.date(bySettingHour: hour, minute: minute, second: second, of: Date(timeIntervalSince1970: TimeInterval(day * 24 * 3600))) {
            return newDate
        } else {
            // Return the original date in case of any issues
            print("Date formatting failed")
            return self
        }
    }
    
    func addMinutesToDate(minutesToAdd: Int) -> Date {
        let calendar = Calendar.current
        let updatedDate = calendar.date(byAdding: .minute, value: minutesToAdd, to: self)
        if let date = updatedDate{
            return date.formatDateForChart()
        } else {
            return self
        }
    }
    func convertToMMDDYYYY() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy"
        
        if let convertedDate = dateFormatter.date(from: dateFormatter.string(from: self)) {
            return convertedDate
        } else {
            print("COULDNT CONVERT DATE")
            return Date()
        }
    }
    
    
    
}
