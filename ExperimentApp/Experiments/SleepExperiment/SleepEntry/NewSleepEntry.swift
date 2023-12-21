//
//  NewSleepEntry.swift
//  ExperimentApp
//
//  Created by Bell Chen on 12/20/23.
//

import Foundation
//used to show missing items in a new entry
struct NewSleepEntry: Identifiable, Codable{
    let id: UUID
    var date: Date
    var bedtime: Date?
    var waketime: Date?
    var quality: Int?
    var productivity: Int?
    var hoursSlept: Int?
    var minutesSlept: Int?
    
    init(id: UUID = UUID(), date: Date){
        self.id = id
        self.date = date
    }
    init(){
        self.id = UUID()
        self.date = Date()
    }
    //tells if its ready to be converted into a sleepentry
    func isReady(experiment: SleepExperiment) -> Bool{
        
        
        switch(experiment.independentVariable){
        case .bedtime:
            if bedtime == nil{
                return false
            }
        case .waketime:
            if waketime == nil{
                return false
            }
        case .both:
            if bedtime == nil || waketime == nil{
                return false
            }
        case .hoursSlept:
            if hoursSlept == nil || minutesSlept == nil {
                return false
            }
        }
    
        switch(experiment.dependentVariable){
        case .quality:
            if quality == nil{
                return false
            }
        case .productivity:
            if productivity ==  nil{
                return false
            }
        case .both:
            if quality == nil || productivity == nil {
                return false
            }
        }
        
        return true
    
    }
}
