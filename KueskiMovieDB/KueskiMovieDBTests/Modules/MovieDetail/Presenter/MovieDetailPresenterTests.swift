//
//  MovieDetailPresenterTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieDetailPresenterTests: XCTestCase {
    private var presenter: MovieDetailPresenter!
    private var mockStorageService: MockMovieStorageService!
    private var movie: Movie!

    override func setUp() {
        super.setUp()

        mockStorageService = MockMovieStorageService()
        movie = StubMovie.getStubMovie()
        let viewModel = MovieDetailViewModel(movie: movie)
        presenter = MovieDetailPresenter(viewModel: viewModel, movieStorageService: mockStorageService)
    }

    override func tearDown() {
        presenter = nil
        mockStorageService = nil
        movie = nil

        super.tearDown()
    }

    func testSaveMovie_whenNotFavorite_callsSaveMovie() throws {
        // Arrange
        movie.isFavorite = false
        mockStorageService.saveMovieError = nil
        
        // Act
        let expectation = XCTestExpectation(description: "Save movie completed")
        presenter.saveMovie { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mockStorageService.saveMovieCalled)
        XCTAssertEqual(mockStorageService.saveMovieModel, movie)
    }

    func testSaveMovie_whenFavorite_callsDeleteMovie() throws {
        // Arrange
        presenter.viewModel.movie.isFavorite = true
        mockStorageService.deleteMovieError = nil
        
        // Act
        let expectation = XCTestExpectation(description: "Save movie completed")
        presenter.saveMovie { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mockStorageService.deleteMovieCalled)
        XCTAssertFalse(movie.isFavorite)
    }

    func testSaveMovie_whenServiceFails_callsCompletionWithError() throws {
        // Arrange
        movie.isFavorite = false
        let expectedError = NSError(domain: "TestErrorDomain", code: 1, userInfo: nil)
        mockStorageService.saveMovieError = expectedError
        
        // Act
        let expectation = XCTestExpectation(description: "Save movie completed")
        presenter.saveMovie { error in
            XCTAssertEqual(error as NSError?, expectedError)
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mockStorageService.saveMovieCalled)
    }
}
