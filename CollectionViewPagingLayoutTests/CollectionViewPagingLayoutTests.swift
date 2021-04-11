//
//  CollectionViewPagingLayoutTests.swift
//  CollectionViewPagingLayoutTests
//
//  Created by Amir on 11/04/2021.
//  Copyright © 2021 Amir. All rights reserved.
//

import XCTest
@testable import CollectionViewPagingLayout

class CollectionViewPagingLayoutTests: XCTestCase {

    func testAssignToCollectionView() throws {
        let layout = CollectionViewPagingLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        XCTAssert(collectionView.collectionViewLayout == layout)
    }

}
