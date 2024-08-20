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
    var mockDataSource: MockDataSource!
    
    override func setUp() {
        super.setUp()
        
        layout = GridCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 0, y: 0, width: 320, height: 640)
        mockDataSource = MockDataSource()
        collectionView.dataSource = mockDataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TestCell")
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
    
    func testPrepare_CreatesLayoutAttributes() {
        layout.prepare()
        
        XCTAssertEqual(layout.cache.count, 10, "Expected 10 layout attributes in cache")
        
        let expectedContentHeight: CGFloat = 5 * 400
        XCTAssertEqual(layout.collectionViewContentSize.height, expectedContentHeight, "Expected content height to be \(expectedContentHeight)")
    }
    
    func testLayoutAttributesForItem() {
        layout.prepare()
        
        let indexPath = IndexPath(item: 0, section: 0)
        let attributes = layout.layoutAttributesForItem(at: indexPath)
        
        XCTAssertNotNil(attributes, "Expected layout attributes to be non-nil")
        XCTAssertEqual(attributes?.indexPath, indexPath, "Expected attributes indexPath to be \(indexPath)")
        
        let actualWidth = attributes?.frame.width ?? 0
        let actualHeight = attributes?.frame.height ?? 0
        
        let expectedWidth: CGFloat = 150.0
        let expectedHeight: CGFloat = 390.0
        
        XCTAssertEqual(actualWidth, expectedWidth, accuracy: 0.01, "Expected attributes frame width to be \(expectedWidth)")
        XCTAssertEqual(actualHeight, expectedHeight, accuracy: 0.01, "Expected attributes frame height to be \(expectedHeight)")
    }
}

final class MockDataSource: NSObject, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath)
    }
}
