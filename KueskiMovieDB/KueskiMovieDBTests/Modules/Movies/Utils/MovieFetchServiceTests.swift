//
//  MovieFetchServiceTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieFetchingServiceTests: XCTestCase {
    private var service: MovieFetchingService!
    private var mockInteractor: MockMoviesFetchingInteractor!

    override func setUp() {
        super.setUp()
        mockInteractor = MockMoviesFetchingInteractor()
        service = MovieFetchingService(fetchingInteractor: mockInteractor)
    }

    override func tearDown() {
        service = nil
        mockInteractor = nil
        super.tearDown()
    }

    func testGetSavedMovies_success() async {
        // Arrange
        let expectedMovies = [StubMovie.getStubMovie()]
        mockInteractor.getSavedMoviesResult = expectedMovies

        // Act
        do {
            let movies = try await service.getSavedMovies()
            // Assert
            XCTAssertTrue(mockInteractor.getSavedMoviesCalled)
            XCTAssertEqual(movies, expectedMovies)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }

    func testGetSavedMovies_failure() async {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockInteractor.getSavedMoviesError = expectedError

        // Act
        do {
            _ = try await service.getSavedMovies()
            XCTFail("Expected error but got success")
        } catch let error as NSError {
            // Assert
            XCTAssertTrue(mockInteractor.getSavedMoviesCalled)
            XCTAssertEqual(error.domain, expectedError.domain)
            XCTAssertEqual(error.code, expectedError.code)
        }
    }
}
