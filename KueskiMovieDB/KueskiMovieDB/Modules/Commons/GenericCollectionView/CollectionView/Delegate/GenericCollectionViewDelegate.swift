//
//  GenericCollectionViewDelegate.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

final class GenericCollectionViewDelegate<Item>: NSObject, UICollectionViewDelegate {
    internal var items: [Item]
    private var didSelectItem: (Item) -> ()
    
    init(items: [Item], didSelectItem: @escaping (Item) -> ()) {
        self.items = items
        self.didSelectItem = didSelectItem
    }
    
    func updateItems(with newItems: [Item]) {
        self.items = newItems
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row >= 0 && indexPath.row < items.count else {
            return
        }
        
        let selectedItem = items[indexPath.row]
        didSelectItem(selectedItem)
    }
}
