//
//  MoviesInteractorTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MoviesInteractorTests: XCTestCase {
    private var interactor: MoviesInteractor!
    private var mockMoviesUseCase: MockMoviesUseCase!
    private var mockDatabaseManager: MockDatabaseManager!

    override func setUp() {
        super.setUp()
        mockMoviesUseCase = MockMoviesUseCase()
        mockDatabaseManager = MockDatabaseManager()
        interactor = MoviesInteractor(
            repository: mockMoviesUseCase,
            databaseRepository: mockDatabaseManager
        )
    }

    override func tearDown() {
        interactor = nil
        mockMoviesUseCase = nil
        mockDatabaseManager = nil
        super.tearDown()
    }

    func testGetMovieList_callsRepository() async throws {
        // Arrange
        let queryParams = MoviesQueryParams(nowPlayingMovies: 1, sortBy: .popularityDesc)
        let expectedMovies = [StubMovie.getStubMovie()]
        mockMoviesUseCase.executeResult = expectedMovies

        // Act
        let movies = try await interactor.getMovieList(queryParams: queryParams)
        
        // Assert
        XCTAssertTrue(mockMoviesUseCase.executeCalled)
        XCTAssertEqual(movies, expectedMovies)
    }
    
    func testSaveMovie_callsDatabaseManager() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie()
        
        // Act
        try await interactor.saveMovie(model: movie)
        
        // Assert
        XCTAssertTrue(mockDatabaseManager.saveDataCalled)
    }
    
    func testGetSavedMovies_callsDatabaseManager() async throws {
        // Arrange
        let expectedMovies = [StubMovie.getStubMovie()]
        mockDatabaseManager.fetchDataResult = expectedMovies

        // Act
        let movies = try await interactor.getSavedMovies()
        
        // Assert
        XCTAssertEqual(movies, expectedMovies)
    }
    
    func testDeleteMovie_callsDatabaseManager() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie()
        
        // Act
        try await interactor.deleteMovie(model: movie)
        
        // Assert
        XCTAssertTrue(mockDatabaseManager.deleteDataCalled)
    }
}
