//
//  MockMoviesInteractor.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB

final class MockMoviesInteractor: MoviesNetworkProtocol, MoviesFetchingProtocol {
    
    var queryParamsPassed: MoviesQueryParams?
    var savedMovies: [Movie] = []
    var errorToThrow: Error?
    
    func getSavedMovies() async throws -> [Movie] {
        if let error = errorToThrow {
            throw error
        }
        return savedMovies
    }
    
    func getMovieList(queryParams: MoviesQueryParams) async throws -> [Movie] {
        queryParamsPassed = queryParams
        if let error = errorToThrow {
            throw error
        }
        return savedMovies
    }
}
