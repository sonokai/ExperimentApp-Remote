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
    //makes pm precede am, used for bedtiem charts
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
    //puts everything on the same date so a chart can plot it
    func formatDateForNonBedtimeChart() -> Date{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        // Extract the time components
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        
        // Create a new date with the specified day and the extracted time components
        if let newDate = calendar.date(bySettingHour: hour, minute: minute, second: second, of: Date(timeIntervalSince1970: 0)) {
            return newDate
        } else {
            // Return the original date in case of any issues
            print("Date formatting failed")
            return self
        }
    }
    
    func roundDateToNearest30Low() -> Date{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        // Extract the time components
        let hour = components.hour ?? 0
        var minute = components.minute ?? 0
        let second = components.second ?? 0
        if(minute >= 30){
            minute = 30
        } else if(minute>0){
            minute = 0
        }
        if let newDate = calendar.date(bySettingHour: hour, minute: minute, second: second, of: Date(timeIntervalSince1970: 0)) {
            return newDate
        } else {
            // Return the original date in case of any issues
            print("Date formatting failed")
            return self
        }
    }
    
    func roundDateToNearest30High() -> Date{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        // Extract the time components
        var hour = components.hour ?? 0
        var minute = components.minute ?? 0
        let second = components.second ?? 0
        if(minute > 30){
            minute = 0
            hour = hour+1
        } else if(minute>0){
            minute = 30
        }
        if let newDate = calendar.date(bySettingHour: hour, minute: minute, second: second, of: Date(timeIntervalSince1970: 0)) {
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
    static func getMonth(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        if let date1 = date {
            return dateFormatter.string(from: date1)
        } else {
            return "????"
        }
        
    }
    static func formatToMonthAndDay(date: Date?) -> String {
        if let date1 = date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d"
            return dateFormatter.string(from: date1)
        } else {
            return "????"
        }
    }
    static func simplifySecondsToTimeString(_ seconds: Double) -> String{
        var newSeconds = Int(seconds.truncatingRemainder(dividingBy: 86400))
        let newHours = newSeconds/3600
        let newMinutes = (newSeconds%3600)/60
        newSeconds = newSeconds%60
        
        var dateComponents = DateComponents()
        dateComponents.hour = newHours
        dateComponents.minute = newMinutes
        dateComponents.second = newSeconds
        
        if let date = Calendar.current.date(from: dateComponents){
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "h:mm a"
            let dateString = dateformatter.string(from: date)
            return dateString
        }
        
        return "Couldn't calculate date"
    }
}
//for history charts
extension SleepExperiment{
    //used for dependentvariable history, bedtime history, waketime history, and sleeptime history
    //uses the date range to calculate an appropriate x axis tick size (the number of days to stride by)
    //returns a day
    func getXAxisTickSize() -> Int{
        let (startDate, endDate) = getDateRange()
        let difference = endDate.timeIntervalSince(startDate)
        let daysDifference = difference / 86_400
        if(daysDifference >= 160){
            return 60
        }
        if(daysDifference >= 80){
            return 30
        }
        if(daysDifference >= 40){
            return 14
        }
        if(daysDifference >= 21){
            return 7
        }
        if(daysDifference >= 12){
            return 5
        }
        if(daysDifference >= 9){
            return 3
        }
        if(daysDifference >= 6){
            return 2
        }
        return 1
    }
    //returns a domain for a graph that depicts history
    //used for dependentvariable history, bedtime history, waketime history, and sleeptime history
    // returns a closed range of date
    func getXDomain() -> ClosedRange<Date>{
        let (startDate, endDate) = getDateRange()
        let difference = endDate.timeIntervalSince(startDate) //assumes
        let daysDifference = difference / 86_400
        let tickSize = getXAxisTickSize()
        var totalTicks = daysDifference / Double(tickSize)
        totalTicks = totalTicks+1
        let timeToAdd = floor(totalTicks) * Double(tickSize) * 86_400
        return (startDate...startDate.addingTimeInterval(timeToAdd))
    }
    //takes in an independent variable to tell what it should do
    //returns the highest and lowest time of an independent variable in seconds
    func getYAxisRange(independentVariable: IndependentVariable) -> (Double, Double){
        var least = (Double)(0)
        var most = (Double)(0)
        for entry in entries{
            var seconds: Double
            switch(independentVariable){
            case .bedtime:
                seconds = SleepExperiment.getBedtimeSeconds(from: entry.bedtime)
            case .waketime:
                seconds = SleepExperiment.getWaketimeSeconds(from: entry.waketime)
            case .hoursSlept:
                seconds = Double(SleepExperiment.getSleepTimeSeconds(from: entry))
            case .both:
                print("used .both as an independent variable for getYAxisRange, which shouldn't ever happen")
                return (0,0)
            }
            
            if(seconds < least || least == 0){
                least = seconds
            }
            if(seconds > most){
                most = seconds
            }
        }
        return (least, most)
    }
    func getYDomain(independentVariable: IndependentVariable) -> ClosedRange<Double>{
        if(independentVariable == .both){
            print("used .both as an independent variable for getyDomain, which shouldn't ever happen")
            return (0...0)
        }
        let (least, most) = getYAxisRange(independentVariable: independentVariable)
        let tickSize = getYAxisTickSize(independentVariable: independentVariable)
        let startTicks = Double(floor(least/tickSize))
        let endTicks = Double(floor(most/tickSize))
        if(startTicks<=0){
            return 0...(endTicks*tickSize+tickSize)
        }
        if(independentVariable == .bedtime){
            if(startTicks*tickSize-tickSize < 43200){
                return 43200...(endTicks*tickSize+tickSize)
            }
        }
        return (startTicks*tickSize-tickSize)...(endTicks*tickSize+tickSize)
    }
    //returns seconds to stride the y axis by
    func getYAxisTickSize(independentVariable: IndependentVariable) -> Double{
        if(independentVariable == .both){
            print("used .both as an independent variable for getyaxisticksize, which shouldn't ever happen")
            return 0
        }
        //want: 4 marks per chart at least
        let (least, most) =  getYAxisRange(independentVariable: independentVariable)
        let startHour = Double(floor(least/3600))
        let endHour = Double(floor(most/3600))
        let difference = endHour - startHour + 2
        if(difference > 16){
            return 14_400
        }
        if(difference > 8){
            return 7_200
        }
        if(difference > 4){
            return 3_600
        }
        if(difference > 2){
            return 1_800
        }
        return 900
    }
    //returns standard deviation of indepedent variable as a nice string
    func formatStandardDeviation(independentVariable: IndependentVariable) -> String{
        var (hour, minute): (Int, Int)
        switch(independentVariable){
        case .bedtime:
            (hour, minute) = getBedtimeStandardDeviation()
        case .waketime:
            (hour, minute) = getWaketimeStandardDeviation()
        case .hoursSlept:
            (hour, minute) = getSleepTimeStandardDeviation()
        case .both:
            print("Shouldn't call formatstandarddeivation using .both as independent variable")
            (hour, minute) = getBedtimeStandardDeviation()
        }
        if(hour == 0){
            return "\(minute) minutes"
        }
        return "\(hour) hours, \(minute) minutes"
    }
    
}

//for scatterplot charts
extension SleepExperiment{
    func getYAxisLabel(_ secondary: DependentVariable = .quality) -> String{
        switch(dependentVariable){
        case .quality: return "Quality of day"
        case .productivity: return "Productivity"
        case .both:
            return secondary.name
        }
    }
}
