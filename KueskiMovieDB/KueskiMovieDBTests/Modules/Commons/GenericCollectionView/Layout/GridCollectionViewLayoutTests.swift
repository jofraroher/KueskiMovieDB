//
//  GridCollectionViewLayoutTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class GridCollectionViewLayoutTests: XCTestCase {
    
    var layout: GridCollectionViewLayout!
    var collectionView: UICollectionView!
    
    override func setUp() {
        super.setUp()
        
        layout = GridCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 0, y: 0, width: 320, height: 640)
        collectionView.dataSource = MockDataSource()
        collectionView.layoutIfNeeded()
        layout.prepare()
    }
    
    func testLayoutAttributesForElements() {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 640)
        let attributes = layout.layoutAttributesForElements(in: rect)
        
        XCTAssertNotNil(attributes, "Expected layout attributes to be non-nil")
        
        for attribute in attributes! {
            XCTAssertTrue(rect.intersects(attribute.frame), "Expected frame to intersect with rect")
        }
    }
    
    func testCollectionViewContentSize() {
        let contentSize = layout.collectionViewContentSize
        
        XCTAssertEqual(contentSize.width, 320, "Expected content width to be 320")
    }
}

private class MockDataSource: NSObject, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
