//
//  PaginationServiceFactory.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol PaginationServiceFactoryProtocol {
    func makePaginationService(interactor: MoviesNetworkProtocol) -> PaginationServiceProtocol
}

final class NowPlayingServiceFactory: PaginationServiceFactoryProtocol {
    func makePaginationService(interactor: MoviesNetworkProtocol) -> PaginationServiceProtocol {
        return PaginationService<Movie> { page, sortBy in
            let queryParams = MoviesQueryParams(nowPlayingMovies: page, sortBy: sortBy)
            return try await interactor.getMovieList(queryParams: queryParams)
        }
    }
}

final class PopularPaginationServiceFactory: PaginationServiceFactoryProtocol {
    func makePaginationService(interactor: MoviesNetworkProtocol) -> PaginationServiceProtocol {
        return PaginationService<Movie> { page, sortBy in
            let queryParams = MoviesQueryParams(popularMovies: page, sortBy: sortBy)
            return try await interactor.getMovieList(queryParams: queryParams)
        }
    }
}
