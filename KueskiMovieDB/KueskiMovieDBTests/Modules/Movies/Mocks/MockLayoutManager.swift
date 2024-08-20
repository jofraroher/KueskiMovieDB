//
//  MockLayoutManager.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockLayoutManager: LayoutManagerProtocol {
    var currentLayoutType: LayoutType = .list
    var switchLayoutCalled = false
    
    func switchLayout(to type: LayoutType) {
        currentLayoutType = type
        switchLayoutCalled = true
    }
    
    func currentLayout() -> UICollectionViewLayout {
        return UICollectionViewFlowLayout()
    }
}
