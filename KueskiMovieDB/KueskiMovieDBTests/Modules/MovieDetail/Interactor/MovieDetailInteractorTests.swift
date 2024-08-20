//
//  MovieDetailInteractorTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieDetailInteractorTests: XCTestCase {
    private var interactor: MovieDetailInteractor!
    private var mockDatabaseManager: MockDatabaseManager!
    
    override func setUp() {
        super.setUp()
        
        mockDatabaseManager = MockDatabaseManager()
        interactor = MovieDetailInteractor(databaseRepository: mockDatabaseManager)
    }
    
    override func tearDown() {
        interactor = nil
        mockDatabaseManager = nil
        
        super.tearDown()
    }
    
    func testSaveMovie_callsSaveData() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie()
        
        // Act
        try await interactor.saveMovie(model: movie)
        
        // Assert
        XCTAssertTrue(mockDatabaseManager.saveDataCalled)
        XCTAssertEqual(mockDatabaseManager.saveDataModel, movie)
    }
    
    func testDeleteMovie_callsDeleteData() async throws {
        // Arrange
        let movie = StubMovie.getStubMovie()
        let expectedId = String(movie.id)
        
        // Act
        try await interactor.deleteMovie(model: movie)
        
        // Assert
        XCTAssertTrue(mockDatabaseManager.deleteDataCalled)
        XCTAssertEqual(mockDatabaseManager.deleteDataRequest, expectedId)
    }
}
