//
//  ScaleTransformViewOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 19/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

/// Options for `ScaleTransformView`
public struct ScaleTransformViewOptions {
    
    // MARK: Properties
    
    /// the corner radius that be applied on `scalableView`
    var cornerRadius: CGFloat = 50
    
    /// The minimum scale factor for side views
    var minScale: CGFloat = 0.75
    
    /// The amount of translate for side views calculated by `scalableView`
    /// for instance, if translationRatio.x = 0.5 and scalableView.width = 100 then
    /// translateX = 50 for the right view and translateX = -50 for the left view
    var translationRatio: CGPoint = .init(x: 0.93, y: 0.36)
    
    /// Since it applies scale on views the spacing between views wouldn't be equal
    /// by default, if this flag is enabled it will keep spacing between items equally
    var keepVerticalSpacingEqual: Bool = true
    
    /// Like `keepHorizontalSpacingEqual` but for horizontal spacing
    var keepHorizontalSpacingEqual: Bool = true
    
    /// Set this flag to `false` if you don't want any shadow for `scalableView`
    var shadowEnabled: Bool = true
    
    /// The curve function for scaling
    var scaleCurve: TransformCurve = .linear
    
    /// The curve function for translating
    var translationCurve: TransformCurve = .linear
    
    /// The shadow color that be applied on `scalableView`
    var shadowColor: UIColor = .black
    
    /// The shadow opacity that be applied on `scalableView`
    var shadowOpacity: Float = 0.6
    
    /// The shadow radius that be applied on `scalableView` when scale is minimum
    var shadowRadiusMin: CGFloat = 2
    
    /// The shadow radius that be applied on `scalableView` when scale is maximum
    var shadowRadiusMax: CGFloat = 13
    
    /// The shadow offset that be applied on `scalableView` when scale is minimum
    var shadowOffsetMin: CGSize = .init(width: 0, height: 2)
    
    /// The shadow offset that be applied on `scalableView` when scale is maximum
    var shadowOffsetMax: CGSize = .init(width: 0, height: 6)
    
    /// The shadow opacity that be applied on `scalableView` when scale is minimum
    var shadowOpacityMin: Float = 0.1
    
    /// The shadow opacity that be applied on `scalableView` when scale is maximum
    var shadowOpacityMax: Float = 0.1
}
