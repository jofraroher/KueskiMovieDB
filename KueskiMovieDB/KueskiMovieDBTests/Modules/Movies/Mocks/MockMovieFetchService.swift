//
//  MockMovieFetchService.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest

@testable import KueskiMovieDB

final class MockMovieFetchService: MovieFetchingServiceProtocol {
    var fetchSavedMoviesCalled = false
    var fetchSavedMoviesResult: [Movie] = []
    
    func getSavedMovies() async throws -> [Movie] {
        fetchSavedMoviesCalled = true
        return fetchSavedMoviesResult
    }
}
