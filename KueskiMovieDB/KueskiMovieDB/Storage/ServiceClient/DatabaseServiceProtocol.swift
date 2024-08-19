//
//  DatabaseServiceProtocol.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol DatabaseServiceProtocol {
    func fetchData<T: DomainObjectConvertible>(for request: String, type: T.Type) async throws -> [T.DomainType]
    func saveData<T: StorableDomainProtocol>(_ data: T, for request: String) async throws
    func deleteData(for request: String) async throws
}
