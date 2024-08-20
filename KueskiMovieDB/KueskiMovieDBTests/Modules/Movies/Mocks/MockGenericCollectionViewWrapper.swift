//
//  MockGenericCollectionView.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockGenericCollectionViewWrapper<Movie>: GenericCollectionView<Movie> {
    var handleDataLoadCompletionCalled = false
    var loadedItems: [Movie] = []
    
    override func handleDataLoadCompletion(with items: [Movie]) {
        handleDataLoadCompletionCalled = true
        loadedItems = items
        super.handleDataLoadCompletion(with: items)
    }
    
    var setLayoutWithAnimationCalled = false
    
    override func setLayoutWithAnimation(layout: UICollectionViewLayout) {
        setLayoutWithAnimationCalled = true
        super.setLayoutWithAnimation(layout: layout)
    }
}
