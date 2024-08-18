//
//  CollectionViewLayoutAnimator.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

final class CollectionViewLayoutAnimator {
    static func animateLayoutChange(for collectionView: UICollectionView, with layout: UICollectionViewLayout) {
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        UIView.performWithoutAnimation {
            collectionView.performBatchUpdates({
                collectionView.reloadData()
            }) { _ in
                let visibleCells = collectionView.visibleCells
                visibleCells.forEach { cell in
                    cell.alpha = 0.0
                }
                
                UIView.animate(withDuration: 0.3) {
                    visibleCells.forEach { cell in
                        cell.alpha = 1.0
                    }
                }
            }
        }
    }
}
