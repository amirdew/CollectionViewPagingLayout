//
//  ScaleTransformViewOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 19/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public struct ScaleTransformViewOptions {
    
    // MARK: Properties
    
    var cornerRadius: CGFloat = 50
    var minScale: CGFloat = 0.75
    var translationRatio: CGPoint = .init(x: 0.93, y: 0.36)
    var keepVerticalSpacingEqual: Bool = true
    var keepHorizontalSpacingEqual: Bool = true
    var shadowEnabled: Bool = true
    var scaleCurve: TransformCurve = .linear
    var translationCurve: TransformCurve = .linear
    var shadowColor: UIColor = .black
    var shadowOpacity: Float = 0.6
    var shadowRadiusMin: CGFloat = 2
    var shadowRadiusMax: CGFloat = 13
    var shadowOffsetMin: CGSize = .init(width: 0, height: 2)
    var shadowOffsetMax: CGSize = .init(width: 0, height: 6)
    var shadowOpacityMin: Float = 0.1
    var shadowOpacityMax: Float = 0.1
}
