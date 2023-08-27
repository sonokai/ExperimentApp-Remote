//
//  DataStore.swift
//  ExperimentApp
//
//  Created by Bell Chen on 8/27/23.
//

import SwiftUI

@MainActor
class DataStore: ObservableObject {
    @Published var data: AppData = AppData.emptyData
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("app.data")
    }
    
    func load() async throws {
        let task = Task<AppData, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return AppData.emptyData
            }
            let data1 = try JSONDecoder().decode(AppData.self, from: data)
            return data1
        }
        let data = try await task.value
        self.data = data
    }
    
    func save(appdata: AppData) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(self.data)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
