//
//  MovieDetailInteractor.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

final class MovieDetailInteractor {
    
    private let databaseRepository: DatabaseManagerProtocol
    
    init(databaseRepository: DatabaseManagerProtocol) {
        self.databaseRepository = databaseRepository
    }
}

extension MovieDetailInteractor: MoviesDatabaseProtocol {
    func saveMovie(model: Movie) async throws {
        try await databaseRepository.saveData(model, for: String())
    }
    
    func getSavedMovies() async throws -> [Movie] {
        try await databaseRepository.fetchData(for: String(), type: MovieEntity.self)
    }
    
    func deleteMovie(model: Movie) async throws {
        try await databaseRepository.deleteData(for: String(model.id))
    }
}
