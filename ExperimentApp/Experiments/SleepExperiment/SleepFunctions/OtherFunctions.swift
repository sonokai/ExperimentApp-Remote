//
//  OtherFunctions.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/30/23.
//

import Foundation

extension SleepExperiment{
    
    func getTitle() -> String{
        var string1 = ""
        switch(self.independentVariable){
            case .bedtime: string1 = "Bedtime"
            case .waketime: string1 = "Wake time"
            case .both: string1 = "Both Bedtime and Waketime"
            case .hoursSlept: string1 = "Hours slept "
        }
        var string2 = ""
        switch(self.dependentVariable){
            case .quality: string2 = "Quality of day"
            case .productivity: string2 = "Productivity"
            case .both: string2 = "Quality of day and Productivity"
        }
        
        return string1 + " vs. " + string2
    }
    func getChartTitle(buttonValue: String, independentVariable: IndependentVariable) -> String{
        if(dependentVariable == .both){
            switch(buttonValue){
            case "none":
                return "Loading chart..."
            case "quality":
                return "\(independentVariable.rawValue) vs. quality of day"
            case "productivity":
                return "\(independentVariable.rawValue) vs. productivity"
            case "compare":
                return "\(independentVariable.rawValue) vs. quality of day and productivity"
            default:
                return "AHHHHH IT broke "
            }
        
        }else{
            return self.getTitle()
        }

    }
    static func getChartTitle2(independentVariable: IndependentVariable, dependentVariable: DependentVariable) -> String{
        
        switch(dependentVariable){
        case .quality:
            return "\(independentVariable.rawValue) vs. quality of day"
        case .productivity:
            return "\(independentVariable.rawValue) vs. productivity"
        default:
            return "AHHHHH IT broke "
        }
        
    }
}





//Other functions
extension SleepExperiment{
    //should not be called if entries.count = 0
    //assumes that the entries are in order
    func getDateRange() -> (Date, Date){
        var minDate: Date?
        var maxDate: Date?

            for entry in entries {
                if let date = minDate, entry.date < date {
                    minDate = entry.date
                }
                if let date = maxDate, entry.date > date {
                    maxDate = entry.date
                }
                if minDate == nil {
                    minDate = entry.date
                }
                if maxDate == nil {
                    maxDate = entry.date
                }
            }
        if let date1 = minDate, let date2 = maxDate{
            let calendar = Calendar.current
            return (calendar.startOfDay(for: date1), date2)
        } else {
            return (Date(), Date())
        }
    }
    //sort entries in order from earliest to latest date
    mutating func sortEntriesByDate() {
        entries = entries.sorted(by: {$0.date < $1.date})
    }
    mutating func initiateSleepEntry(){
        entries.append(SleepEntry(newEntry: newSleepEntry))
        newSleepEntry = NewSleepEntry()
    }
    func dateStringFromMinutes(minutes: Int) -> String{
        if let date = Calendar.current.date(bySettingHour: minutes/60, minute: minutes % 60, second: 0, of: Date()){
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.dateFormat = "H:mm a"
            return dateFormatter.string(from: date)
        } else {
            if let date2 = Calendar.current.date(bySettingHour: ((minutes/60)-24), minute: minutes % 60, second: 0, of: Date()){
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .short
                dateFormatter.dateFormat = "H:mm a"
                return dateFormatter.string(from: date2)
            }
            else{
                return "I broke"
            }
        }
    }
    
    
}

