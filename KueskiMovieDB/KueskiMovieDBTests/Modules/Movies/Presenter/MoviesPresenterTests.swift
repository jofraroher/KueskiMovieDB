//
//  MoviesPresenterTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MoviesPresenterTests: XCTestCase {
    private var presenter: MoviesPresenter!
    private var mockView: MockMoviesView!
    private var mockRouter: MockMoviesRouter!
    private var movieFetchingService: MockMovieFetchService!
    private var mockSyncService: MockMovieSyncService!
    private var mockPaginationServiceFactory: MockPaginationServiceFactory!
    private var mockPaginationService: MockPaginationService!
    private var mockInteractor: MockMoviesInteractor!

    override func setUp() {
        super.setUp()

        mockView = MockMoviesView()
        mockRouter = MockMoviesRouter()
        movieFetchingService = MockMovieFetchService()
        mockSyncService = MockMovieSyncService()
        mockPaginationServiceFactory = MockPaginationServiceFactory()
        mockPaginationService = MockPaginationService()
        mockInteractor = MockMoviesInteractor()

        mockPaginationServiceFactory.paginationServiceToReturn = mockPaginationService

        presenter = MoviesPresenter(
            interactor: mockInteractor,
            movieFetchingService: movieFetchingService,
            paginationServiceFactory: mockPaginationServiceFactory,
            syncService: mockSyncService
        )
        presenter.view = mockView
        presenter.router = mockRouter
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockRouter = nil
        movieFetchingService = nil
        mockSyncService = nil
        mockPaginationServiceFactory = nil
        mockPaginationService = nil
        mockInteractor = nil

        super.tearDown()
    }

    func testUpdateMovieList_success() {
        // Arrange
        let reloadDataExpectation = XCTestExpectation(description: "Reload data expectation")
        let mockMovies: [Movie] = [StubMovie.getStubMovie()]
        mockView.reloadDataExpectation = reloadDataExpectation
        mockPaginationService.fetchNextPageResult = mockMovies
        mockSyncService.syncWithSavedMoviesResult = mockMovies

        // Act
        presenter.updateMovieList()

        // Assert
        wait(for: [reloadDataExpectation], timeout: 1)
        XCTAssertTrue(mockView.reloadDataCalled)
        XCTAssertEqual(mockView.items, mockMovies)
    }

    func testUpdateMovieList_failure() {
        // Arrange
        let reloadDataExpectation = XCTestExpectation(description: "Reload data expectation")
        let showAlertExpectation = XCTestExpectation(description: "Show alert expectation")
        mockPaginationService.fetchNextPageError = NSError(domain: "", code: 0, userInfo: nil)
        mockView.reloadDataExpectation = reloadDataExpectation
        mockView.showAlertExpectation = showAlertExpectation
        // Act
        presenter.updateMovieList()

        // Assert
        wait(for: [reloadDataExpectation, showAlertExpectation], timeout: 1)
        XCTAssertTrue(mockView.reloadDataCalled)
        XCTAssertTrue(mockView.showAlertCalled)
        XCTAssertTrue(presenter.items.isEmpty)
    }

    func testUpdateMovieListBySort_success() {
        // Arrange
        let reloadDataExpectation = XCTestExpectation(description: "Reload data expectation")
        let mockMovies: [Movie] = [StubMovie.getStubMovie()]
        mockPaginationService.fetchBySortResult = mockMovies
        mockSyncService.syncWithSavedMoviesResult = mockMovies
        mockView.reloadDataExpectation = reloadDataExpectation
        
        // Act
        presenter.updateMovieListBySort(sortBy: .popularityDesc)

        // Assert
        wait(for: [reloadDataExpectation], timeout: 1)
        XCTAssertTrue(mockView.reloadDataCalled)
        XCTAssertEqual(mockView.items, mockMovies)
    }

    func testUpdateMovieListBySort_failure() {
        // Arrange
        let showAlertExpectation = XCTestExpectation(description: "Show alert expectation")
        let reloadDataExpectation = XCTestExpectation(description: "Reload data expectation")
        mockPaginationService.fetchBySortError = NSError(domain: "", code: 0, userInfo: nil)
        mockView.showAlertExpectation = showAlertExpectation
        mockView.reloadDataExpectation = reloadDataExpectation
        // Act
        presenter.updateMovieListBySort(sortBy: .popularityDesc)

        // Assert
        wait(for: [showAlertExpectation, reloadDataExpectation], timeout: 1)
        XCTAssertTrue(mockView.showAlertCalled)
        XCTAssertTrue(mockView.reloadDataCalled)
        XCTAssertTrue(presenter.items.isEmpty)
    }

    func testNavigateToMovieDetail() {
        // Act
        presenter.navigateToMovieDetail(model: StubMovie.getStubMovie())

        // Assert
        XCTAssertTrue(mockRouter.navigateToMovieDetailCalled)
    }
    
    @MainActor
    func testUpdateMovieStatus_updatesFavoriteStatus() {
        // Arrange
        let movieId = 1
        let initialMovie = StubMovie.getStubMovie()
        presenter.items = [initialMovie]
        
        let reloadDataExpectation = XCTestExpectation(description: "Reload data expectation")
        mockView.reloadDataExpectation = reloadDataExpectation
        
        // Act
        presenter.updateMovieStatus(with: movieId, isFavorite: true)
        
        // Assert
        wait(for: [reloadDataExpectation], timeout: 1)
        
        XCTAssertEqual(presenter.items.first(where: { $0.id == movieId })?.isFavorite, true)
        XCTAssertTrue(mockView.reloadDataCalled)
    }
    
    func testRefreshStatus_failure() {
        // Arrange
        let error = NSError(domain: "", code: 0, userInfo: nil)
        mockSyncService.syncWithSavedMoviesError = error
        let showAlertExpectation = XCTestExpectation(description: "Show alert expectation")
        mockView.showAlertExpectation = showAlertExpectation
        
        // Act
        presenter.refreshStatu()
        
        // Assert
        wait(for: [showAlertExpectation], timeout: 1)
        XCTAssertTrue(mockView.showAlertCalled)
    }
    
    func testUpdateMovieListBySort_invalidResponse() {
        // Arrange
        let expectedError = KueskiMovieRequestError.invalidResponse
        
        mockPaginationService.fetchBySortResult = ["Invalid", "Data"]
        
        let showAlertExpectation = XCTestExpectation(description: "Show alert expectation")
        mockView.showAlertExpectation = showAlertExpectation

        // Act
        presenter.updateMovieListBySort(sortBy: .popularityDesc)

        // Assert
        wait(for: [showAlertExpectation], timeout: 1)
        XCTAssertTrue(mockView.showAlertCalled, "Expected showAlert to be called")
        XCTAssertTrue(presenter.items.isEmpty, "Expected items to be empty on error")
    }
    
    func testUpdateMovieList_invalidResponse() {
        // Arrange
        mockPaginationService.fetchNextPageResult = ["Invalid", "Data"]
        
        let showAlertExpectation = XCTestExpectation(description: "Show alert expectation")
        mockView.showAlertExpectation = showAlertExpectation

        // Act
        presenter.updateMovieList()

        // Assert
        wait(for: [showAlertExpectation], timeout: 1)
        XCTAssertTrue(mockView.showAlertCalled, "Expected showAlert to be called")
        XCTAssertTrue(presenter.items.isEmpty, "Expected items to be empty on error")
    }
}
