//
//  PaginationServiceFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol PaginationServiceFactoryProtocol {
    func makePaginationService(interactor: MoviesInteractorProtocol) -> PaginationServiceProtocol
}

final class PaginationServiceFactory: PaginationServiceFactoryProtocol {
    func makePaginationService(interactor: MoviesInteractorProtocol) -> PaginationServiceProtocol {
        return PaginationService<Movie> { page, sortBy in
            let queryParams = MoviesQueryParams(nowPlayingMovies: page, sortBy: sortBy)
            return try await interactor.getMovieList(queryParams: queryParams)
        }
    }
}
