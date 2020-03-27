//
//  StackTransformViewOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 21/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public struct StackTransformViewOptions {
    
    // MARK: Properties
    
    /// The scale factor for computing scale of each card, the scale for the top card is 1
    /// and the scale for the card just below top card is (1 - scaleFactor) and so on
    public var scaleFactor: CGFloat
    
    /// The maximum number of visible card in the stack
    public var maxStackSize: Int
    
    /// 
    public var spacingFactor: CGFloat
    
    public var opacityReduceFactor: CGFloat
    
    public var bottomStackOpacitySpeedFactor: CGFloat
    
    public var topStackOpacitySpeedFactor: CGFloat
    
    public var perspectiveRatio: CGFloat
    
    public var shadowEnabled: Bool
    
    public var shadowColor: UIColor
    
    public var shadowOpacity: Float
    
    public var shadowOffset: CGSize
    
    public var stackRotateAngel: CGFloat
    
    public var shadowRadius: CGFloat
    
    public var popAngle: CGFloat
    
    public var popOffsetRatio: CGSize
    
    public var stackPosition: Position
    
    public var reverse: Bool
    
    public var blurEffectEnabled: Bool
    
    public var maxBlurEffectRadius: CGFloat
    
    public var blurEffectStyle: UIBlurEffect.Style
    
    
    // MARK: Lifecycle
    
    public init(
        scaleFactor: CGFloat = 0.15,
        maxStackSize: Int = 4,
        spacingFactor: CGFloat = 0.1,
        opacityReduceFactor: CGFloat = 0.0,
        bottomStackOpacitySpeedFactor: CGFloat = 0.9,
        topStackOpacitySpeedFactor: CGFloat = 0.3,
        perspectiveRatio: CGFloat = 0.45,
        shadowEnabled: Bool = true,
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.05,
        shadowOffset: CGSize = .zero,
        stackRotateAngel: CGFloat = .pi/15,
        shadowRadius: CGFloat = 10,
        popAngle: CGFloat = .pi/7,
        popOffsetRatio: CGSize = .init(width: -1.3, height: 0.3),
        stackPosition: Position = .top,
        reverse: Bool = false,
        blurEffectEnabled: Bool = true,
        maxBlurEffectRadius: CGFloat = 0.1,
        blurEffectStyle: UIBlurEffect.Style = .light
    ) {
        self.scaleFactor = scaleFactor
        self.maxStackSize = maxStackSize
        self.spacingFactor = spacingFactor
        self.opacityReduceFactor = opacityReduceFactor
        self.bottomStackOpacitySpeedFactor = bottomStackOpacitySpeedFactor
        self.topStackOpacitySpeedFactor = topStackOpacitySpeedFactor
        self.perspectiveRatio = perspectiveRatio
        self.shadowEnabled = shadowEnabled
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.stackRotateAngel = stackRotateAngel
        self.shadowRadius = shadowRadius
        self.popAngle = popAngle
        self.popOffsetRatio = popOffsetRatio
        self.stackPosition = stackPosition
        self.reverse = reverse
        self.blurEffectEnabled = blurEffectEnabled
        self.maxBlurEffectRadius = maxBlurEffectRadius
        self.blurEffectStyle = blurEffectStyle
    }
}


public extension StackTransformViewOptions {
    enum Position {
        case top
        case right
        case bottom
        case left
    }
}
