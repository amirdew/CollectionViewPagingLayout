//
//  ScaleTransformViewOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 19/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

/// Options for `ScaleTransformView`
public struct ScaleTransformViewOptions {
    
    // MARK: Properties
    
    /// the corner radius that be applied on `scalableView`
    var cornerRadius: CGFloat = 50
    
    /// The minimum scale factor for side views
    var minScale: CGFloat = 0.75
    
    /// The maximum scale factor for side views
    var maxScale: CGFloat = 1
    
    /// Ratio for computing scale for each item
    /// Scale = 1 - progress * `scaleRatio`
    var scaleRatio: CGFloat = 0.25
    
    /// Ratio for the amount of translate for side views, calculates by `scalableView` size
    /// for instance, if translationRatio.x = 0.5 and scalableView.width = 100 then
    /// translateX = 50 for the right view and translateX = -50 for the left view
    var translationRatio: CGPoint = .init(x: 0.93, y: 0.36)
    
    /// The minimum amount of translate for side views, calculates like `translationRatio`
    var minTranslationRatio: CGPoint? = .init(x: -5, y: -5)
    
    /// The maximum amount of translate for side views, calculates like `translationRatio`
    var maxTranslationRatio: CGPoint? = .init(x: 5, y: 5)
    
    /// Since it applies scale on views the spacing between views wouldn't be equal
    /// by default, if this flag is enabled it will keep spacing between items equally
    var keepVerticalSpacingEqual: Bool = true
    
    /// Like `keepHorizontalSpacingEqual` but for horizontal spacing
    var keepHorizontalSpacingEqual: Bool = true
                
    /// The curve function for scaling
    var scaleCurve: TransformCurve = .linear
    
    /// The curve function for translating
    var translationCurve: TransformCurve = .linear
    
    /// Set this flag to `false` if you don't want any shadow for `scalableView`
    var shadowEnabled: Bool = true
    
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
    
    /// Enabling the blur effect for side views
    var blurEffectEnabled: Bool = false
    
    /// The maximum blur radius for side views between 0 and 1
    var maxBlurEffectRadius: CGFloat = 0.4
    
    /// Blur effect style in case you enable it
    var blurEffectStyle: UIBlurEffect.Style = .light
    
    /// 3D rotation based on CATransform3DMakeRotation(angle:CGFloat, x: CGFloat, y: CGFloat, z: CGFloat)
    var rotation3d: Rotation3dOptions? = nil
    
    /// 3D translation based on CATransform3DMakeTranslation(tx: CGFloat, ty: CGFloat, tz: CGFloat)
    var translation3d: Translation3dOptions? = nil
}


public extension ScaleTransformViewOptions {
    
    struct Translation3dOptions {
        
        /// The translates(x,y,z) ratios (translateX = progress * translates.x)
        var translateRatios: (CGFloat, CGFloat, CGFloat)
        
        /// The minimum translate values
        var minTranslates: (CGFloat, CGFloat, CGFloat)
        
        /// The maximum translate values
        var maxTranslates: (CGFloat, CGFloat, CGFloat)
    }
    
    
    struct Rotation3dOptions {
        
        /// The angle for rotate side views
        var angle: CGFloat
        
        /// The minimum angle for rotation
        var minAngle: CGFloat
        
        /// The maximum angle for rotation
        var maxAngle: CGFloat
        
        var x: CGFloat
        
        var y: CGFloat
        
        var z: CGFloat
        
        /// `CATransform3D.m34`, read more: https://stackoverflow.com/questions/3881446/meaning-of-m34-of-catransform3d
        var m34: CGFloat
        
        /// `CALayer.isDoubleSided`, read more: https://developer.apple.com/documentation/quartzcore/calayer/1410924-isdoublesided
        var isDoubleSided: Bool = false
    }
}
