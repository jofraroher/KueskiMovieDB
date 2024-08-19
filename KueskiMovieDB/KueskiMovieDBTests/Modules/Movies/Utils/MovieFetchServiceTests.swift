//
//  MovieFetchServiceTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieFetchServiceTests: XCTestCase {
    var movieFetchService: MovieFetchingService!
    var mockInteractor: MockMoviesInteractor!

    override func setUp() {
        super.setUp()
        mockInteractor = MockMoviesInteractor()
        movieFetchService = MovieFetchingService(fetchingInteractor: mockInteractor)
    }

    override func tearDown() {
        movieFetchService = nil
        mockInteractor = nil
        super.tearDown()
    }
}
