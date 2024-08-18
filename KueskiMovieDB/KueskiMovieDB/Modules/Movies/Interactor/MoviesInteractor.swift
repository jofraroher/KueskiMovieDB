//
//  MoviesInteractor.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class MoviesInteractor {
    
    private let repository: NowPlayingMoviesListUseCaseProtocol
    
    init(repository: NowPlayingMoviesListUseCaseProtocol) {
        self.repository = repository
    }
}

extension MoviesInteractor: MoviesInteractorProtocol {
    func getMovieList(queryParams: MoviesQueryParams) async throws -> [Movie] {
        try await repository.execute(queryParams: queryParams)
    }
}
