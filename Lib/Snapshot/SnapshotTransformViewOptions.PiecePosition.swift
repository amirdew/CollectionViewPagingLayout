//
//  SnapshotTransformViewOptions.PiecePosition.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 27/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public extension SnapshotTransformViewOptions {
    
    struct PiecePosition {
        
        // MARK: Properties
        
        let index: Int
        let row: Int
        let column: Int
        let rowCount: Int
        let columnCount: Int
        
        
        // MARK: Lifecycle
        
        internal init(index: Int, row: Int, column: Int, rowCount: Int, columnCount: Int) {
            self.index = index
            self.row = row
            self.column = column
            self.rowCount = rowCount
            self.columnCount = columnCount
        }
    }
    
}
