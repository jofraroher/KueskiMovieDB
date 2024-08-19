//
//  MovieStorageService.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

protocol MovieStorageServiceProtocol: AnyObject {
    func deleteMovie(model: Movie) async throws
    func saveMovie(model: Movie) async throws
}

final class MovieStorageService: MovieStorageServiceProtocol {
    private let storageInteractor: MoviesDatabaseProtocol
    
    init(storageInteractor: MoviesDatabaseProtocol ) {
        self.storageInteractor = storageInteractor
    }
    
    func deleteMovie(model: Movie) async throws {
        try await storageInteractor.deleteMovie(model: model)
    }
    
    func saveMovie(model: Movie) async throws {
        try await storageInteractor.saveMovie(model: model)
    }
}
