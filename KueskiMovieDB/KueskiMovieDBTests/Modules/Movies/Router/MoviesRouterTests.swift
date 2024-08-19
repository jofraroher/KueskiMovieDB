//
//  MoviesRouterTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MoviesRouterTests: XCTestCase {
    
    func testNavigateToMovieDetail() {
        // Arrange
        let mockNavigationController = MockNavigationController()
        let mockViewController = MockViewController()
        mockViewController.mockNavigationController = mockNavigationController
        let router = MoviesRouter()
        router.view = mockViewController
        
        // Act
        router.navigateToMovieDetail(model: StubMovie.getStubMovie())
        
        // Assert
        XCTAssertTrue(mockNavigationController.pushViewControllerCalled)
    }
}
