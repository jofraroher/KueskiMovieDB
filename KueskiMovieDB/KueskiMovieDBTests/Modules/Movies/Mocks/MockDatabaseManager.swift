//
//  MockDatabaseManager.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB

final class MockDatabaseManager: DatabaseManagerProtocol {
    var saveDataCalled = false
    var fetchDataResult: [Movie] = []
    var fetchDataError: Error?
    var deleteDataCalled = false

    func fetchData<T>(for request: String, type: T.Type) async throws -> [T.DomainType] where T: DomainObjectConvertible {
        if let error = fetchDataError {
            throw error
        }
        return fetchDataResult as! [T.DomainType]
    }

    func saveData<T>(_ data: T, for request: String) async throws where T: StorableDomainProtocol {
        saveDataCalled = true
    }

    func deleteData(for request: String) async throws {
        deleteDataCalled = true
    }
}
