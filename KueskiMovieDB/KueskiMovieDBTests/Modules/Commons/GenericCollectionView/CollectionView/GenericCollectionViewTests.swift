//
//  GenericCollectionViewTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class GenericCollectionViewTests: XCTestCase {
    
    func testRefreshData_fetchesRemoteDataWhenNotFetching() {
        // Arrange
        var didFetchRemoteData = false
        let collectionView = GenericCollectionView<Int>(
            items: [],
            configureCell: { _, _ in },
            didSelectItem: { _ in },
            fetchRemoteData: {
                didFetchRemoteData = true
            }
        )
        
        collectionView.isFetching = false
        
        // Act
        collectionView.refreshData(self)
        
        // Assert
        XCTAssertTrue(didFetchRemoteData, "fetchRemoteData should be called when not already fetching")
        XCTAssertTrue(collectionView.isFetching, "isFetching should be set to true after fetchRemoteData is called")
    }
    
    func testRefreshData_doesNotFetchRemoteDataWhenFetching() {
        // Arrange
        var didFetchRemoteData = false
        let collectionView = GenericCollectionView<Int>(
            items: [],
            configureCell: { _, _ in },
            didSelectItem: { _ in },
            fetchRemoteData: {
                didFetchRemoteData = true
            }
        )
        
        collectionView.isFetching = true
        
        // Act
        collectionView.refreshData(self)
        
        // Assert
        XCTAssertFalse(didFetchRemoteData, "fetchRemoteData should not be called when already fetching")
        XCTAssertTrue(collectionView.isFetching, "isFetching should remain true")
    }
    
    func testPrefetchItemsAt_callsFetchRemoteDataNearEndOfItems() {
        // Arrange
        var didFetchRemoteData = false
        let items = [1, 2, 3, 4, 5]
        let collectionView = GenericCollectionView<Int>(
            items: items,
            configureCell: { _, _ in },
            didSelectItem: { _ in },
            fetchRemoteData: {
                didFetchRemoteData = true
            }
        )
        
        collectionView.isFetching = false
        
        // Act
        let indexPaths = [IndexPath(row: 4, section: 0)]
        collectionView.collectionView(collectionView, prefetchItemsAt: indexPaths)
        
        // Assert
        XCTAssertTrue(didFetchRemoteData, "fetchRemoteData should be called when near the end of the items list")
    }
    
    func testPrefetchItemsAt_doesNotCallFetchRemoteDataWhenNotNearEnd() {
        // Arrange
        var didFetchRemoteData = false
        let items = [1, 2, 3, 4, 5]
        let collectionView = GenericCollectionView<Int>(
            items: items,
            configureCell: { _, _ in },
            didSelectItem: { _ in },
            fetchRemoteData: {
                didFetchRemoteData = true
            }
        )
        
        collectionView.isFetching = false
        
        // Act
        let indexPaths = [IndexPath(row: 1, section: 0)]
        collectionView.collectionView(collectionView, prefetchItemsAt: indexPaths)
        
        // Assert
        XCTAssertFalse(didFetchRemoteData, "fetchRemoteData should not be called when not near the end of the items list")
    }
}
