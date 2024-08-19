//
//  MockMovieSyncService.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockMovieSyncService: MovieSyncServiceProtocol {
    var syncWithSavedMoviesCalled = false
    var syncWithSavedMoviesResult: [Movie] = []

    var expectation: XCTestExpectation?
    
    func syncWithSavedMovies(newItems: [Movie], fetchingService: MovieFetchingServiceProtocol) async throws -> [Movie] {
        syncWithSavedMoviesCalled = true
        expectation?.fulfill()
        return syncWithSavedMoviesResult
    }
}
