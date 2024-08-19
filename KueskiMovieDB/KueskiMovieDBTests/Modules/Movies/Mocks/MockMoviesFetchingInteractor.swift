//
//  MockMoviesFetchingInteractor.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockMoviesFetchingInteractor: MoviesFetchingProtocol {
    var getSavedMoviesCalled = false
    var getSavedMoviesResult: [Movie] = []
    var getSavedMoviesError: Error?
    
    func getSavedMovies() async throws -> [Movie] {
        getSavedMoviesCalled = true
        if let error = getSavedMoviesError {
            throw error
        }
        return getSavedMoviesResult
    }
}
