//
//  StackTransformViewOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 21/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

/// Options for `StackTransformView`
public struct StackTransformViewOptions {
    
    // MARK: Properties
    
    /// the corner radius that be applied on `cardView`
    var cornerRadius: CGFloat = 20
    
    var scaleFactor: CGFloat = 0.15
    
    var maxStackSize: Int = 4
    
    var spacingFactor: CGFloat = 0.1
    
    var opacityReduceFactor: CGFloat = 0.0
    
    var bottomStackOpacitySpeedFactor: CGFloat = 0.9
    
    var topStackOpacitySpeedFactor: CGFloat = 0.3
    
    var perspectiveRatio: CGFloat = 0.45
    
    var shadowEnabled: Bool = true
    
    var shadowColor: UIColor = .black
    
    var shadowOpacity: Float = 0.05
    
    var shadowOffset: CGSize = .zero
    
    var stackRotateAngel: CGFloat = .pi/15
    
    var shadowRadius: CGFloat = 10
    
    var popAngle: CGFloat = .pi/7
    
    var popOffsetRatio: CGSize = .init(width: -1.3, height: 0.3)
    
    var stackPosition: Position = .top
    
    var reverse: Bool = false
    
    var blurEffectEnabled: Bool = true
    
    var maxBlurEffectRadius: CGFloat = 0.1
    
    var blurEffectStyle: UIBlurEffect.Style = .light
}


public extension StackTransformViewOptions {
    enum Position {
        case top
        case right
        case bottom
        case left
    }
}
