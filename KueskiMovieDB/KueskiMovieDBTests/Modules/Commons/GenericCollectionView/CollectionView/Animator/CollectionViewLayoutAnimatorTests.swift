//
//  CollectionViewLayoutAnimatorTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
import UIKit
@testable import KueskiMovieDB

final class CollectionViewLayoutAnimatorTests: XCTestCase {

    func testLayoutChangeWithoutAnimation() {
        let initialLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: initialLayout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        
        let newLayout = UICollectionViewFlowLayout()
        
        CollectionViewLayoutAnimator.animateLayoutChange(for: collectionView, with: newLayout)
        
        XCTAssertEqual(collectionView.collectionViewLayout, newLayout)
    }
    
    func testVisibleCellsAlphaDuringAnimation() {
        let initialLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: initialLayout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        
        collectionView.reloadData()
        let visibleCells = collectionView.visibleCells
        
        let newLayout = UICollectionViewFlowLayout()
        
        CollectionViewLayoutAnimator.animateLayoutChange(for: collectionView, with: newLayout)
        
        visibleCells.forEach { cell in
            XCTAssertEqual(cell.alpha, 0.0)
        }
        
        UIView.animate(withDuration: 0.3) {
            visibleCells.forEach { cell in
                cell.alpha = 1.0
            }
        }
        
        visibleCells.forEach { cell in
            XCTAssertEqual(cell.alpha, 1.0)
        }
    }
}

extension CollectionViewLayoutAnimatorTests: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
