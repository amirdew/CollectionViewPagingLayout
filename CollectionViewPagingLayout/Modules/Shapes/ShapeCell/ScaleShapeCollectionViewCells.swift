//
//  ScaleShapeCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class ScaleLinearShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        cornerRadius: 30,
        minScale: 0.6,
        translationRatio: CGPoint(x: 0.66, y: 0.2),
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true,
        scaleCurve: .linear,
        translationCurve: .linear
    )
}


class ScaleEaseInShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        cornerRadius: 30,
        minScale: 0.6,
        translationRatio: CGPoint(x: 0.66, y: 0.2),
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true,
        scaleCurve: .easeIn,
        translationCurve: .linear
    )
}


class ScaleEaseOutShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        cornerRadius: 30,
        minScale: 0.6,
        translationRatio: CGPoint(x: 0.66, y: 0.2),
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true,
        scaleCurve: .linear,
        translationCurve: .easeIn
    )
}
