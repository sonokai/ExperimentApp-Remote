//
//  ExperimentAppTests.swift
//  ExperimentAppTests
//
//  Created by Kai Green on 7/7/23.
//

import XCTest
@testable import ExperimentApp

final class ExperimentAppTests: XCTestCase {
    func testStandardDeviation() throws {
        let array = [0,1,2,3,4,5]
        let standardDeviation = SleepExperiment.getStandardDeviationOfArray(array: array)
        print("Standard deviation: \(standardDeviation)")
        XCTAssertEqual(1.7078,standardDeviation, accuracy: 0.001)
    }
    

}
