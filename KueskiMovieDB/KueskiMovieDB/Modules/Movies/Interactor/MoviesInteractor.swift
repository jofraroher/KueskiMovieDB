//
//  MoviesInteractor.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class MoviesInteractor {
    
    private let repository: MoviesUseCaseProtocol
    private let databaseRepository: DatabaseManagerProtocol
    
    init(
        repository: MoviesUseCaseProtocol,
        databaseRepository: DatabaseManagerProtocol
    ) {
        self.repository = repository
        self.databaseRepository = databaseRepository
    }
}

extension MoviesInteractor: MoviesNetworkProtocol {
    func getMovieList(queryParams: MoviesQueryParams) async throws -> [Movie] {
        try await repository.execute(queryParams: queryParams)
    }
}

extension MoviesInteractor: MoviesFetchingProtocol {
    func getSavedMovies() async throws -> [Movie] {
        try await databaseRepository.fetchData(for: String(), type: MovieEntity.self)
    }
}
