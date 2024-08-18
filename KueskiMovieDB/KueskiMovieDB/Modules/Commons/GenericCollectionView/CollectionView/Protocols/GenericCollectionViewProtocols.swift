//
//  GenericCollectionViewProtocols.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

protocol ConfigurableCell {
    associatedtype Item
    func configure(with item: Item)
}

protocol CollectionViewDelegate: AnyObject {
    associatedtype Item
    func didSelectItem(_ item: Item)
}

protocol CollectionViewDataSource {
    associatedtype Item
    func numberOfItems() -> Int
    func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell
}
