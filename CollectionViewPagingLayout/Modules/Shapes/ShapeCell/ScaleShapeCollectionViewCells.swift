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
        maxTranslationRatio: CGPoint(x: 2, y: 0),
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


class ScalePerspectiveShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        cornerRadius: 30,
        minScale: 1,
        translationRatio: CGPoint(x: 1.36, y: 0.2),
        maxTranslationRatio: CGPoint(x: 15, y: 0),
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true,
        scaleCurve: .linear,
        translationCurve: .linear,
        rotation3d: .init(angle: .pi/12, minAngle: -.pi/2, maxAngle: .pi/2, x: 0, y: 1, z: 0, m34: -0.0015),
        translation3d: .init(translateRatios: (100, 0, -600), minTranslates: (-1000000, 0, -100000), maxTranslates: (1000000, 0, -400))
    )
}
