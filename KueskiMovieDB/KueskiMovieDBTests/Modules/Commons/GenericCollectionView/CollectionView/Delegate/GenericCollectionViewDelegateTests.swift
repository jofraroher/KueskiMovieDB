//
//  GenericCollectionViewDelegateTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class GenericCollectionViewDelegateTests: XCTestCase {
    
    var collectionViewDelegate: GenericCollectionViewDelegate<String>!
    var selectedItem: String?
    
    override func setUp() {
        super.setUp()
        
        collectionViewDelegate = GenericCollectionViewDelegate(items: ["Item 1", "Item 2", "Item 3"]) { item in
            self.selectedItem = item
        }
    }
    
    override func tearDown() {
        collectionViewDelegate = nil
        selectedItem = nil
        super.tearDown()
    }
    
    func testInitialItems() {
        XCTAssertEqual(collectionViewDelegate.items, ["Item 1", "Item 2", "Item 3"])
    }
    
    func testUpdateItems() {
        collectionViewDelegate.updateItems(with: ["New Item 1", "New Item 2"])
        XCTAssertEqual(collectionViewDelegate.items, ["New Item 1", "New Item 2"])
    }
    
    func testDidSelectItem() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewDelegate.collectionView(collectionView, didSelectItemAt: IndexPath(row: 1, section: 0))
        
        XCTAssertEqual(selectedItem, "Item 2")
    }
    
    func testDidSelectItemOutOfBounds() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewDelegate.collectionView(collectionView, didSelectItemAt: IndexPath(row: 5, section: 0))
        
        XCTAssertNil(selectedItem)
    }
}
