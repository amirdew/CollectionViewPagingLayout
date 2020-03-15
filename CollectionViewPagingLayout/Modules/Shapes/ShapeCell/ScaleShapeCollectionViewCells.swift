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
        minScale: 0.6,
        scaleRatio: 0.4,
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
        minScale: 0.6,
        scaleRatio: 0.4,
        translationRatio: CGPoint(x: 0.66, y: 0.2),
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true,
        scaleCurve: .easeIn,
        translationCurve: .linear
    )
}


class ScaleEaseOutShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        minScale: 0.6,
        scaleRatio: 0.4,
        translationRatio: CGPoint(x: 0.66, y: 0.2),
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true,
        scaleCurve: .linear,
        translationCurve: .easeIn
    )
}


class ScalePerspectiveShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        minScale: 1.2,
        maxScale: 1.2,
        scaleRatio: 0,
        translationRatio: .zero,
        minTranslationRatio: .zero,
        maxTranslationRatio: .zero,
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true,
        scaleCurve: .linear,
        translationCurve: .linear,
        shadowEnabled: false,
        rotation3d: .init(angle: .pi/3, minAngle: -.pi, maxAngle: .pi, x: 0, y: -1, z: 0, m34: -0.002),
        translation3d: .init(translateRatios: (0, 0, 0), minTranslates: (0, 0, -210), maxTranslates: (0, 0, -210))
    )
}
