//
//  MoviesViewControllerTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MoviesViewControllerTests: XCTestCase {
    
    var viewController: MoviesViewController!
    var mockPresenter: MockMoviesPresenter!
    var mockLayoutManager: MockLayoutManager!
    var mockCollectionViewFactory: MockCollectionViewFactory!
    var mockCollectionViewWrapper: MockGenericCollectionViewWrapper<Movie>!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockMoviesPresenter()
        mockLayoutManager = MockLayoutManager()
        mockCollectionViewWrapper = MockGenericCollectionViewWrapper<Movie>(
            frame: .zero,
            layout: UICollectionViewFlowLayout(),
            items: [],
            configureCell: { _, _ in },
            didSelectItem: { _ in },
            fetchRemoteData: { }
        )
        
        mockCollectionViewFactory = MockCollectionViewFactory()
        mockCollectionViewFactory.mockCollectionViewWrapper = mockCollectionViewWrapper
        
        viewController = MoviesViewController(
            presenter: mockPresenter,
            layoutManager: mockLayoutManager,
            collectionViewFactory: mockCollectionViewFactory
        )
        
        let window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        mockPresenter = nil
        mockLayoutManager = nil
        mockCollectionViewFactory = nil
        mockCollectionViewWrapper = nil
        super.tearDown()
    }
    
    func testSetupUIConfiguresCollectionView() {
        // Assert
        XCTAssertNotNil(viewController.reusableCollectionView, "CollectionView should be configured")
        XCTAssertTrue(viewController.reusableCollectionView === mockCollectionViewWrapper, "CollectionView should be set to the mock collection view")
    }
    
    @MainActor
    func testReloadDataUpdatesCollectionView() {
        // Arrange
        let movies: [Movie] = [StubMovie.getStubMovie()]
        
        // Act
        viewController.reloadData(items: movies)
        
        // Assert
        XCTAssertTrue(mockCollectionViewWrapper.handleDataLoadCompletionCalled, "handleDataLoadCompletion should have been called")
        XCTAssertEqual(mockCollectionViewWrapper.loadedItems, movies, "Collection view should have loaded the correct items")
    }
    
    func testListTappedSwitchesLayoutToList() {
        // Arrange
        mockLayoutManager.currentLayoutType = .grid
        
        // Act
        viewController.listTapped()
        
        // Assert
        XCTAssertEqual(mockLayoutManager.currentLayoutType, .list, "Layout should be switched to list")
        XCTAssertTrue(mockCollectionViewWrapper.setLayoutWithAnimationCalled, "setLayoutWithAnimation should have been called")
    }
    
    func testGridTappedSwitchesLayoutToGrid() {
        // Arrange
        mockLayoutManager.currentLayoutType = .list  // Inicialmente en lista
        
        // Act
        viewController.gridTapped()
        
        // Assert
        XCTAssertEqual(mockLayoutManager.currentLayoutType, .grid, "Layout should be switched to grid")
        XCTAssertTrue(mockCollectionViewWrapper.setLayoutWithAnimationCalled, "setLayoutWithAnimation should have been called")
    }
    
    func testShowAlertDisplaysAlert() {
        // Act
        viewController.showAlert()
        
        // Assert
        XCTAssertTrue(viewController.presentedViewController is UIAlertController, "An alert should be presented")
        let alertController = viewController.presentedViewController as? UIAlertController
        XCTAssertEqual(alertController?.title, "Oops!", "The alert title should be 'Oops!'")
        XCTAssertEqual(alertController?.message, "Something went wrong. Please try again later.", "The alert message should be correct")
    }
    
    func testSortTapped() {
        viewController.sortTapped()
        
        let presentedViewController = viewController.presentedViewController as? UIAlertController
        XCTAssertNotNil(presentedViewController, "Expected UIAlertController to be presented")
        XCTAssertEqual(presentedViewController?.title, "Sort by", "Expected UIAlertController title to be 'Sort by'")
        
        let actionTitles = presentedViewController?.actions.map { $0.title }
        XCTAssertTrue(actionTitles?.contains("Date") ?? false, "Expected 'Date' action to be present")
        XCTAssertTrue(actionTitles?.contains("Name") ?? false, "Expected 'Name' action to be present")
        XCTAssertTrue(actionTitles?.contains("Default") ?? false, "Expected 'Default' action to be present")
        
        let dateAction = presentedViewController?.actions.first { $0.title == "Date" }
        XCTAssertNotNil(dateAction, "Expected 'Date' action to be present")
    }
}
