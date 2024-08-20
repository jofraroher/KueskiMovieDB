//
//  MockLayoutProvider.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockLayoutProvider: LayoutProvider {
    var layoutCreated: UICollectionViewLayout?
    
    func createLayout() -> UICollectionViewLayout {
        return layoutCreated ?? UICollectionViewLayout()
    }
}
