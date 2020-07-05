//
//  ShapeLayout+ScaleOptions.swift
//  PagingLayoutSamples
//
//  Created by Amir on 27/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import CollectionViewPagingLayout

extension ShapeLayout {
    var scaleOptions: ScaleTransformViewOptions? {
        switch self {
        case .scaleBlur:
            return ScaleTransformViewOptions(
                minScale: 0.6,
                scaleRatio: 0.4,
                translationRatio: CGPoint(x: 0.66, y: 0.2),
                maxTranslationRatio: CGPoint(x: 2, y: 0),
                blurEffectEnabled: true,
                blurEffectRadiusRatio: 0.2
            )
        case .scaleLinear:
            return ScaleTransformViewOptions(
                minScale: 0.6,
                scaleRatio: 0.4,
                translationRatio: CGPoint(x: 0.66, y: 0.2),
                maxTranslationRatio: CGPoint(x: 2, y: 0),
                keepVerticalSpacingEqual: true,
                keepHorizontalSpacingEqual: true,
                scaleCurve: .linear,
                translationCurve: .linear
            )
        case .scaleEaseIn:
            return ScaleTransformViewOptions(
                minScale: 0.6,
                scaleRatio: 0.4,
                translationRatio: CGPoint(x: 0.66, y: 0.2),
                keepVerticalSpacingEqual: true,
                keepHorizontalSpacingEqual: true,
                scaleCurve: .easeIn,
                translationCurve: .linear
            )
        case .scaleEaseOut:
            return ScaleTransformViewOptions(
                minScale: 0.6,
                scaleRatio: 0.4,
                translationRatio: CGPoint(x: 0.66, y: 0.2),
                keepVerticalSpacingEqual: true,
                keepHorizontalSpacingEqual: true,
                scaleCurve: .linear,
                translationCurve: .easeIn
            )
        case .scaleRotary:
            return ScaleTransformViewOptions(
                minScale: 0,
                scaleRatio: 0.4,
                translationRatio: CGPoint(x: 0.1, y: 0.1),
                minTranslationRatio: CGPoint(x: -1, y: 0),
                maxTranslationRatio: CGPoint(x: 1, y: 1),
                rotation3d: ScaleTransformViewOptions.Rotation3dOptions(angle: .pi / 15, minAngle: -.pi / 3, maxAngle: .pi / 3, x: 0, y: 0, z: 1, m34: -0.004),
                translation3d: .init(translateRatios: (0.9, 0.1, 0),
                                     minTranslateRatios: (-3, -0.8, -0.3),
                                     maxTranslateRatios: (3, 0.8, -0.3))
            )
        case .scaleCylinder:
            return ScaleTransformViewOptions(
                minScale: 0.55,
                maxScale: 0.55,
                scaleRatio: 0,
                translationRatio: .zero,
                minTranslationRatio: .zero,
                maxTranslationRatio: .zero,
                shadowEnabled: false,
                rotation3d: .init(angle: .pi / 4, minAngle: -.pi, maxAngle: .pi, x: 0, y: 1, z: 0, m34: -0.000_4 - 0.8 * 0.000_2 ),
                translation3d: .init(translateRatios: (0, 0, 0), minTranslateRatios: (0, 0, 1.25), maxTranslateRatios: (0, 0, 1.25))
            )
        case .scaleInvertedCylinder:
            return ScaleTransformViewOptions(
                minScale: 1.2,
                maxScale: 1.2,
                scaleRatio: 0,
                translationRatio: .zero,
                minTranslationRatio: .zero,
                maxTranslationRatio: .zero,
                shadowEnabled: false,
                rotation3d: .init(angle: .pi / 3, minAngle: -.pi, maxAngle: .pi, x: 0, y: -1, z: 0, m34: -0.002),
                translation3d: .init(translateRatios: (0.1, 0, 0),
                                     minTranslateRatios: (-0.05, 0, 0.86),
                                     maxTranslateRatios: (0.05, 0, -0.86))
            )
        case .scaleCoverFlow:
            return ScaleTransformViewOptions(
                minScale: 0.7,
                maxScale: 0.7,
                scaleRatio: 0,
                translationRatio: .zero,
                minTranslationRatio: .zero,
                maxTranslationRatio: .zero,
                shadowEnabled: true,
                rotation3d: .init(angle: .pi / 1.65, minAngle: -.pi / 3, maxAngle: .pi / 3, x: 0, y: -1, z: 0, m34: -0.000_5),
                translation3d: .init(translateRatios: (0.1, 0, -0.7), minTranslateRatios: (-0.1, 0, -3), maxTranslateRatios: (0.1, 0, 0))
            )
        default:
            return nil
        }
    }
}
