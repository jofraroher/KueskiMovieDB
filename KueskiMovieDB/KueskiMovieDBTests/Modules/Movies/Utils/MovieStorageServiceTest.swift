//
//  MovieStorageServiceTest.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieStorageServiceTests: XCTestCase {
    private var movieStorageService: MovieStorageService!
    private var mockDatabase: MockMoviesDatabaseProtocol!
    private var sampleMovie: Movie!

    override func setUp() {
        super.setUp()
        mockDatabase = MockMoviesDatabaseProtocol()
        movieStorageService = MovieStorageService(storageInteractor: mockDatabase)
        sampleMovie = StubMovie.getStubMovie()
    }

    override func tearDown() {
        movieStorageService = nil
        mockDatabase = nil
        sampleMovie = nil
        super.tearDown()
    }

    func testDeleteMovie_success() async {
        // Act
        do {
            try await movieStorageService.deleteMovie(model: sampleMovie)
        } catch {
            XCTFail("deleteMovie should not throw an error")
        }

        // Assert
        XCTAssertTrue(mockDatabase.deleteMovieCalled, "deleteMovie should be called on the storageInteractor")
    }

    func testDeleteMovie_failure() async {
        // Arrange
        let expectedError = NSError(domain: "", code: 1, userInfo: nil)
        mockDatabase.deleteMovieError = expectedError

        // Act
        do {
            try await movieStorageService.deleteMovie(model: sampleMovie)
            XCTFail("deleteMovie should throw an error")
        } catch let error as NSError {
            // Assert
            XCTAssertEqual(error, expectedError, "deleteMovie should throw the expected error")
        }
    }

    func testSaveMovie_success() async {
        // Act
        do {
            try await movieStorageService.saveMovie(model: sampleMovie)
        } catch {
            XCTFail("saveMovie should not throw an error")
        }

        // Assert
        XCTAssertTrue(mockDatabase.saveMovieCalled, "saveMovie should be called on the storageInteractor")
    }

    func testSaveMovie_failure() async {
        // Arrange
        let expectedError = NSError(domain: "", code: 2, userInfo: nil)
        mockDatabase.saveMovieError = expectedError

        // Act
        do {
            try await movieStorageService.saveMovie(model: sampleMovie)
            XCTFail("saveMovie should throw an error")
        } catch let error as NSError {
            // Assert
            XCTAssertEqual(error, expectedError, "saveMovie should throw the expected error")
        }
    }
}
