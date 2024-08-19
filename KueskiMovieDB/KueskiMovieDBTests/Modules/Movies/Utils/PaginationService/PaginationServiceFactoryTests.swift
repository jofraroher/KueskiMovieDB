//
//  PaginationServiceFactoryTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class PaginationServiceFactoryTests: XCTestCase {
    var nowPlayingFactory: NowPlayingServiceFactory!
    var popularFactory: PopularPaginationServiceFactory!
    var mockInteractor: MockMoviesInteractor!

    override func setUp() {
        super.setUp()
        nowPlayingFactory = NowPlayingServiceFactory()
        popularFactory = PopularPaginationServiceFactory()
        mockInteractor = MockMoviesInteractor()
    }

    override func tearDown() {
        nowPlayingFactory = nil
        popularFactory = nil
        mockInteractor = nil
        super.tearDown()
    }

    func testNowPlayingServiceFactory_createsPaginationServiceWithNowPlayingParams() async throws {
        // Arrange
        let page = 1
        let sortBy = "popularity.desc"
        
        // Act
        let paginationService = nowPlayingFactory.makePaginationService(interactor: mockInteractor)
        
        // Simulating a request to API
        _ = try await paginationService.fetchNextPage()
        
        // Assert
        XCTAssertEqual(mockInteractor.queryParamsPassed?.page, page)
        XCTAssertEqual(mockInteractor.queryParamsPassed?.sortBy, sortBy)
    }
    
    func testPopularPaginationServiceFactory_createsPaginationServiceWithPopularParams() async throws {
        // Arrange
        let page = 1
        let sortBy = "popularity.desc"
        
        // Act
        let paginationService = popularFactory.makePaginationService(interactor: mockInteractor)
        
        // Simulating a request to API
        _ = try await paginationService.fetchNextPage()
        
        // Assert
        XCTAssertEqual(mockInteractor.queryParamsPassed?.page, page)
        XCTAssertEqual(mockInteractor.queryParamsPassed?.sortBy, sortBy)
    }
}
