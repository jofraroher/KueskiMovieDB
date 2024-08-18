//
//  GenericCollectionViewDelegate.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

final class GenericCollectionViewDelegate<Item>: NSObject, UICollectionViewDelegate {
    private var items: [Item]
    private var didSelectItem: (Item) -> ()
    
    init(items: [Item], didSelectItem: @escaping (Item) -> ()) {
        self.items = items
        self.didSelectItem = didSelectItem
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(items[indexPath.row])
    }
}
