//
//  StackShapeCollectionViewCells.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 21/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class TransparentStackShapeCollectionViewCell: BaseShapeCollectionViewCell, StackTransformView {

    var stackOptions: StackTransformViewOptions = .init(
        scaleFactor: 0.12,
        minScale: 0.0,
        maxStackSize: 4,
        alphaFactor: 0.2,
        bottomStackAlphaSpeedFactor: 10,
        topStackAlphaSpeedFactor: 0.1,
        popAngle: .pi/10,
        popOffsetRatio: .init(width: -1.45, height: 0.3)
    )
}


class PerspectiveStackShapeCollectionViewCell: BaseShapeCollectionViewCell, StackTransformView {

    var stackOptions: StackTransformViewOptions = .init(
        scaleFactor: 0.1,
        minScale: 0.2,
        maxStackSize: 6,
        spacingFactor: 0.08,
        alphaFactor: 0.0,
        perspectiveRatio: 0.3,
        shadowRadius: 5,
        popAngle: .pi/10,
        popOffsetRatio: .init(width: -1.45, height: 0.3),
        stackPosition: CGPoint(x: 1, y: 0)
    )
}


class RotaryStackShapeCollectionViewCell: BaseShapeCollectionViewCell, StackTransformView {

    var stackOptions: StackTransformViewOptions = .init(
        scaleFactor: -0.03,
        minScale: 0.2,
        maxStackSize: 3,
        spacingFactor: 0.01,
        alphaFactor: 0.1,
        shadowRadius: 8,
        stackRotateAngel: .pi/16,
        popAngle: .pi/4,
        popOffsetRatio: .init(width: -1.45, height: 0.4),
        stackPosition: CGPoint(x: 0, y: 1)
    )
}


class VortexStackShapeCollectionViewCell: BaseShapeCollectionViewCell, StackTransformView {

    var stackOptions: StackTransformViewOptions = .init(
        scaleFactor: -0.15,
        minScale: 0.2,
        maxScale: nil,
        maxStackSize: 4,
        spacingFactor: 0,
        alphaFactor: 0.4,
        topStackAlphaSpeedFactor: 1,
        perspectiveRatio: -0.3,
        shadowEnabled: false,
        popAngle: .pi,
        popOffsetRatio: .zero,
        stackPosition: CGPoint(x: 0, y: 1)
    )
}


class ReverseStackShapeCollectionViewCell: BaseShapeCollectionViewCell, StackTransformView {

    var stackOptions: StackTransformViewOptions = .init(
        scaleFactor: 0.1,
        maxScale: nil,
        maxStackSize: 4,
        spacingFactor: 0.08,
        shadowRadius: 8,
        popAngle: -.pi/4,
        popOffsetRatio: .init(width: 1.45, height: 0.4),
        stackPosition: CGPoint(x: -1, y: -0.2),
        reverse: true
    )
}


class BlurStackShapeCollectionViewCell: BaseShapeCollectionViewCell, StackTransformView {

    var stackOptions: StackTransformViewOptions = .init(
        scaleFactor: 0.1,
        maxScale: nil,
        maxStackSize: 7,
        spacingFactor: 0.06,
        topStackAlphaSpeedFactor: 0.1,
        perspectiveRatio: 0.04,
        shadowRadius: 8,
        popAngle: -.pi/4,
        popOffsetRatio: .init(width: 1.45, height: 0.4),
        stackPosition: CGPoint(x: -1, y: 0),
        reverse: true,
        blurEffectEnabled: true,
        maxBlurEffectRadius: 0.08
    )
}
