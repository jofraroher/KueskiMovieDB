//
//  MoviesFactoryTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MoviesFactoryTests: XCTestCase {
    private var mockNavigationFactory: MockNavigationFactory!
    private var mockMoviesUseCase: MockMoviesUseCase!
    private var mockPaginationServiceFactory: MockPaginationServiceFactory!
    
    override func setUp() {
        super.setUp()
        mockNavigationFactory = MockNavigationFactory()
        mockMoviesUseCase = MockMoviesUseCase()
        mockPaginationServiceFactory = MockPaginationServiceFactory()
    }
    
    override func tearDown() {
        mockNavigationFactory = nil
        mockMoviesUseCase = nil
        mockPaginationServiceFactory = nil
        super.tearDown()
    }
    
    func testBuild_createsViewController() {
        // Act
        mockPaginationServiceFactory.paginationServiceToReturn = MockPaginationService()
        let viewController = MoviesFactory.build(
            usingNavigationFactory: mockNavigationFactory.makeNavigationController(rootViewController:),
            repository: mockMoviesUseCase,
            paginationServiceFactory: mockPaginationServiceFactory
        )

        // Assert
        XCTAssertTrue(mockNavigationFactory.buildCalled, "The navigation factory's build method should be called.")
        XCTAssertEqual(viewController as? UINavigationController, viewController, "The navigation controller returned should match the expected navigation controller.")

        guard let navigationController = viewController as? UINavigationController else {
            XCTFail("ViewController is not of type UINavigationController")
            return
        }
        guard let moviesViewController = navigationController.viewControllers.first as? MoviesViewController else {
            XCTFail("Root view controller is not of type MoviesViewController")
            return
        }

        XCTAssertNotNil(moviesViewController.presenter)
        XCTAssertNotNil(moviesViewController.layoutManager)
        XCTAssertNotNil(moviesViewController.collectionViewFactory)

        // Verificar que el Presenter, Router, etc., se han configurado
        let presenter = moviesViewController.presenter as? MoviesPresenter
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.movieFetchingService)
        XCTAssertNotNil(presenter?.paginationService)
        XCTAssertNotNil(presenter?.syncService)
        XCTAssertNotNil(presenter?.router)
    }
}
