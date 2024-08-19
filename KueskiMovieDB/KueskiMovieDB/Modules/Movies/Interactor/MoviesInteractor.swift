//
//  MoviesInteractor.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class MoviesInteractor {
    
    private let repository: NowPlayingMoviesListUseCaseProtocol
    private let databaseRepository: DatabaseManagerProtocol
    
    init(
        repository: NowPlayingMoviesListUseCaseProtocol,
        databaseRepository: DatabaseManagerProtocol
    ) {
        self.repository = repository
        self.databaseRepository = databaseRepository
    }
}

extension MoviesInteractor: MoviesInteractorProtocol {
    func getMovieList(queryParams: MoviesQueryParams) async throws -> [Movie] {
        try await repository.execute(queryParams: queryParams)
    }
    
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
