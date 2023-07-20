//
//  IntEntry.swift
//  ExperimentApp
//
//  Created by Bell Chen on 7/20/23.
//

import Foundation


//two int variables

struct IntEntry: Identifiable {
    let id: UUID
    var date: String
    var independent: Int
    var dependent: Int
    
    init(id: UUID = UUID(), date: String, independent: Int, dependent: Int) {
        self.id = id
        self.date = date
        self.independent = independent
        self.dependent = dependent
        
    }
}


extension IntEntry {
    static let sampleData: [IntEntry] =
    [
        IntEntry(date: "7/1/23", independent: 8, dependent: 7),
        IntEntry(date: "7/2/23", independent: 9, dependent: 9),
        IntEntry(date: "7/3/23", independent: 7, dependent: 6),
        IntEntry(date: "7/4/23", independent: 7, dependent: 7),
        IntEntry(date: "7/5/23", independent: 8, dependent: 8)
    ]
}
