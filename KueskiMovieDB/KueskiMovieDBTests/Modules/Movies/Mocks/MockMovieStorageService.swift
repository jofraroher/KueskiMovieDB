//
//  MockMovieStorageService.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest

@testable import KueskiMovieDB

final class MockMovieStorageService: MovieStorageServiceProtocol {
    var saveMovieCalled = false
    var deleteMovieCalled = false
    var fetchSavedMoviesCalled = false
    var saveMovieResult: Result<Void, Error>?
    var deleteMovieResult: Result<Void, Error>?
    var fetchSavedMoviesResult: [Movie] = []

    var saveMovieExpectation: XCTestExpectation?
    
    func saveMovie(model: Movie) async throws {
        saveMovieCalled = true
        saveMovieExpectation?.fulfill()
        try saveMovieResult?.get()
    }

    func deleteMovie(model: Movie) async throws {
        deleteMovieCalled = true
        try deleteMovieResult?.get()
    }

    func getSavedMovies() async throws -> [Movie] {
        fetchSavedMoviesCalled = true
        return fetchSavedMoviesResult
    }
}
