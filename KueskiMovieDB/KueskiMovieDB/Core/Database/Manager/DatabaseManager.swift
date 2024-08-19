//
//  DatabaseManager.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class DatabaseManager: DatabaseManagerProtocol {

    private let databaseService: DatabaseServiceProtocol

    init(databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }

    func fetchData<T: DomainObjectConvertible>(for request: String, type: T.Type) async throws -> [T.DomainType] {
        try await databaseService.fetchData(for: request, type: type)
    }
    func saveData<T: StorableDomainProtocol>(_ data: T, for request: String) async throws {
        try await databaseService.saveData(data, for: request)
    }

    func deleteData(for request: String) async throws {
        try await databaseService.deleteData(for: request)
    }
}
