//
//  ScaleShapeCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

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


class ScaleCylinderShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        minScale: 0.55,
        maxScale: 0.55,
        scaleRatio: 0,
        translationRatio: .zero,
        minTranslationRatio: .zero,
        maxTranslationRatio: .zero,
        shadowEnabled: false,
        rotation3d: .init(angle: .pi/4, minAngle: -.pi, maxAngle: .pi, x: 0, y: 1, z: 0, m34: -0.0012),
        translation3d: .init(translateRatios: (0, 0, 0), minTranslates: (0, 0, 310), maxTranslates: (0, 0, 310))
    )
}


class ScaleInvertedCylinderShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {

    var options = ScaleTransformViewOptions(
        minScale: 1.2,
        maxScale: 1.2,
        scaleRatio: 0,
        translationRatio: .zero,
        minTranslationRatio: .zero,
        maxTranslationRatio: .zero,
        shadowEnabled: false,
        rotation3d: .init(angle: .pi/3, minAngle: -.pi, maxAngle: .pi, x: 0, y: -1, z: 0, m34: -0.002),
        translation3d: .init(translateRatios: (0, 0, 0), minTranslates: (0, 0, -210), maxTranslates: (0, 0, -210))
    )
}


class ScaleCoverFlowShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    
    var options = ScaleTransformViewOptions(
        minScale: 0.7,
        maxScale: 0.7,
        scaleRatio: 0,
        translationRatio: .zero,
        minTranslationRatio: .zero,
        maxTranslationRatio: .zero,
        shadowEnabled: false,
        rotation3d: .init(angle: .pi/1.65, minAngle: -.pi/3, maxAngle: .pi/3, x: 0, y: -1, z: 0, m34: -0.0005),
        translation3d: .init(translateRatios: (30, 0, -150), minTranslates: (-30, 0, -1000), maxTranslates: (30, 0, 0))
    )
}
