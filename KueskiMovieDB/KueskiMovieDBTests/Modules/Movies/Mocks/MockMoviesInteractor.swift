//
//  MockMoviesInteractor.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB

final class MockMoviesInteractor: MoviesNetworkProtocol, MoviesDatabaseProtocol {
    
    var queryParamsPassed: MoviesQueryParams?
    var savedMovies: [Movie] = []
    var errorToThrow: Error?
    
    func saveMovie(model: Movie) async throws {
        if let error = errorToThrow {
            throw error
        }
        savedMovies.append(model)
    }
    
    func getSavedMovies() async throws -> [Movie] {
        if let error = errorToThrow {
            throw error
        }
        return savedMovies
    }
    
    func deleteMovie(model: Movie) async throws {
        if let error = errorToThrow {
            throw error
        }
        savedMovies.removeAll { $0.id == model.id }
    }
    
    func getMovieList(queryParams: KueskiMovieDB.MoviesQueryParams) async throws -> [Movie] {
        queryParamsPassed = queryParams
        if let error = errorToThrow {
            throw error
        }
        return savedMovies
    }
}
