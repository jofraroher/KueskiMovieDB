//
//  MovieStorageServiceTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieStorageServiceTests: XCTestCase {
    var movieStorageService: MovieStorageService!
    var mockInteractor: MockMoviesInteractor!

    override func setUp() {
        super.setUp()
        mockInteractor = MockMoviesInteractor()
        movieStorageService = MovieStorageService(interactor: mockInteractor)
    }

    override func tearDown() {
        movieStorageService = nil
        mockInteractor = nil
        super.tearDown()
    }

    func testSaveMovie_whenMovieIsNotFavorite_savesMovie() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie()
        
        // Act
        try await movieStorageService.saveMovie(model: movie)
        
        // Assert
        XCTAssertTrue(mockInteractor.savedMovies.contains(movie))
    }
    
    func testSaveMovie_whenMovieIsFavorite_doesNotSaveMovie() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie(isFavorite: true)
        
        // Act
        try await movieStorageService.saveMovie(model: movie)
        
        // Assert
        XCTAssertFalse(mockInteractor.savedMovies.contains(movie))
    }
    
    func testGetSavedMovies_returnsSavedMovies() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie()
        mockInteractor.savedMovies = [movie]
        
        // Act
        let savedMovies = try await movieStorageService.getSavedMovies()
        
        // Assert
        XCTAssertEqual(savedMovies, [movie])
    }
    
    func testDeleteMovie_removesMovie() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie()
        mockInteractor.savedMovies = [movie]
        
        // Act
        try await movieStorageService.deleteMovie(model: movie)
        
        // Assert
        XCTAssertFalse(mockInteractor.savedMovies.contains(movie))
    }
    
    func testSaveMovie_whenInteractorThrows_errorIsPropagated() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie()
        mockInteractor.errorToThrow = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        // Act & Assert
        do {
            try await movieStorageService.saveMovie(model: movie)
            XCTFail("Expected error not thrown")
        } catch {
            // We wait for it to throw the error
        }
    }
}
