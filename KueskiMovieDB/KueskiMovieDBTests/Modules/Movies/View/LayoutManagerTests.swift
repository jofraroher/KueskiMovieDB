//
//  LayoutManagerTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class LayoutManagerTests: XCTestCase {
    
    var layoutManager: LayoutManager!
    var listLayoutProvider: MockLayoutProvider!
    var gridLayoutProvider: MockLayoutProvider!
    
    override func setUp() {
        super.setUp()
        
        listLayoutProvider = MockLayoutProvider()
        gridLayoutProvider = MockLayoutProvider()
        
        // Configura layouts mock
        let listLayout = UICollectionViewFlowLayout()
        let gridLayout = UICollectionViewFlowLayout()
        listLayoutProvider.layoutCreated = listLayout
        gridLayoutProvider.layoutCreated = gridLayout
        
        layoutManager = LayoutManager(
            listLayoutProvider: listLayoutProvider,
            gridLayoutProvider: gridLayoutProvider
        )
    }
    
    func testSwitchToListLayout() {
        layoutManager.switchLayout(to: .list)
        let currentLayout = layoutManager.currentLayout()
        
        XCTAssertTrue(currentLayout is UICollectionViewFlowLayout, "Expected UICollectionViewFlowLayout")
        XCTAssertEqual(listLayoutProvider.layoutCreated, currentLayout, "Expected list layout to be returned")
    }
    
    func testSwitchToGridLayout() {
        layoutManager.switchLayout(to: .grid)
        let currentLayout = layoutManager.currentLayout()
        
        XCTAssertTrue(currentLayout is UICollectionViewFlowLayout, "Expected UICollectionViewFlowLayout")
        XCTAssertEqual(gridLayoutProvider.layoutCreated, currentLayout, "Expected grid layout to be returned")
    }
    
    func testInitialLayoutIsList() {
        let initialLayout = layoutManager.currentLayout()
        
        XCTAssertTrue(initialLayout is UICollectionViewFlowLayout, "Expected UICollectionViewFlowLayout")
        XCTAssertEqual(listLayoutProvider.layoutCreated, initialLayout, "Expected initial layout to be list layout")
    }
}
