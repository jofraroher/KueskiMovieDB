//
//  MockCollectionViewFactory.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockCollectionViewFactory: CollectionViewFactoryProtocol {
    var mockCollectionViewWrapper: MockGenericCollectionViewWrapper<Movie>!
    
    func createCollectionView(
        with frame: CGRect,
        layout: UICollectionViewLayout,
        items: [Movie],
        fetchRemoteData: @escaping (() -> ()),
        didSelectItem: @escaping ((Movie) -> ())
    ) -> GenericCollectionView<Movie> {
        return mockCollectionViewWrapper
    }
}
