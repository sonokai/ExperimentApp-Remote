//
//  Time.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/2/23.
//

import Foundation
enum Time: String, CaseIterable, Identifiable, Codable{
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
    
    var id: String {
        rawValue
    }
}

