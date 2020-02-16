//
//  ShapeCollectionViewCells.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class ScaleShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        cornerRadius: 30,
        minScale: 0.6,
        translationRatio: CGPoint(x: 0.63, y: 0.33),
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true
    )
}
