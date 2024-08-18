//
//  GenericCollectionViewDataSource.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

final class GenericCollectionViewDataSource<Item>: NSObject, UICollectionViewDataSource {
    private var items: [Item]
    private var configureCell: (Item, UICollectionViewCell) -> ()
    
    init(items: [Item], configureCell: @escaping (Item, UICollectionViewCell) -> ()) {
        self.items = items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType: UICollectionViewCell.Type
        if collectionView.collectionViewLayout is ListCollectionViewLayout {
            cellType = MovieListCollectionViewCell.self
        } else {
            cellType = MovieGridCollectionViewCell.self
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath)
        configureCell(items[indexPath.row], cell)
        return cell
    }
}
