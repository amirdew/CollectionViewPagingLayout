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
    
    public var minScale: CGFloat?
    
    public var maxScale: CGFloat?
    
    /// The maximum number of visible card in the stack
    public var maxStackSize: Int
    
    /// 
    public var spacingFactor: CGFloat
    ///
    public var maxSpacing: CGFloat?
    
    public var alphaFactor: CGFloat
    
    public var bottomStackAlphaSpeedFactor: CGFloat
    
    public var topStackAlphaSpeedFactor: CGFloat
    
    public var perspectiveRatio: CGFloat
    
    public var shadowEnabled: Bool
    
    public var shadowColor: UIColor
    
    public var shadowOpacity: Float
    
    public var shadowOffset: CGSize
    
    public var stackRotateAngel: CGFloat
    
    public var shadowRadius: CGFloat
    
    public var popAngle: CGFloat
    
    public var popOffsetRatio: CGSize
    
    public var stackPosition: CGPoint
    
    public var reverse: Bool
    
    public var blurEffectEnabled: Bool
    
    public var maxBlurEffectRadius: CGFloat
    
    public var blurEffectStyle: UIBlurEffect.Style
    
    
    // MARK: Lifecycle
    
    public init(
        scaleFactor: CGFloat = 0.15,
        minScale: CGFloat? = 0,
        maxScale: CGFloat? = 1,
        maxStackSize: Int = 3,
        spacingFactor: CGFloat = 0.03,
        maxSpacing: CGFloat? = nil,
        alphaFactor: CGFloat = 0.0,
        minAlpha: CGFloat = 0.0,
        bottomStackAlphaSpeedFactor: CGFloat = 0.9,
        topStackAlphaSpeedFactor: CGFloat = 0.3,
        perspectiveRatio: CGFloat = 0,
        shadowEnabled: Bool = true,
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.1,
        shadowOffset: CGSize = .zero,
        stackRotateAngel: CGFloat = 0,
        shadowRadius: CGFloat = 10,
        popAngle: CGFloat = .pi/7,
        popOffsetRatio: CGSize = .init(width: -1.3, height: 0.3),
        stackPosition: CGPoint =  CGPoint(x: 0, y: -1),
        reverse: Bool = false,
        blurEffectEnabled: Bool = false,
        maxBlurEffectRadius: CGFloat = 0.0,
        blurEffectStyle: UIBlurEffect.Style = .light
    ) {
        self.scaleFactor = scaleFactor
        self.minScale = minScale
        self.maxScale = maxScale
        self.maxStackSize = maxStackSize
        self.spacingFactor = spacingFactor
        self.maxSpacing = maxSpacing
        self.alphaFactor = alphaFactor
        self.bottomStackAlphaSpeedFactor = bottomStackAlphaSpeedFactor
        self.topStackAlphaSpeedFactor = topStackAlphaSpeedFactor
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
