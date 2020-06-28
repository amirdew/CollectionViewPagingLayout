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
    
    /// The minumum scale for each card, see `scaleFactor`
    public var minScale: CGFloat?
    
    /// The maximum scale for each card, see `scaleFactor`
    public var maxScale: CGFloat?
    
    /// The maximum number of visible cards in the stack
    public var maxStackSize: Int
    
    /// the spacing factor for card positions, computing like this:
    /// cardY = cardHeight * spacingFactor * progress
    public var spacingFactor: CGFloat
    
    /// the maxium spacing for the card position, see `spacingFactor`
    public var maxSpacing: CGFloat?
    
    /// the alpha factor for the card alpha, the alpha for the topest card will be 1
    /// and the alpha for the card just below the top card is (1 - alphaFactor) and so on
    /// alpha = 1 - progress * alphaFactor
    public var alphaFactor: CGFloat
    
    /// the most bottom card of the stack will be fading out with this speed
    /// between 0...1, if you want it to be slow set it to 1
    public var bottomStackAlphaSpeedFactor: CGFloat
    
    /// line `bottomStackAlphaSpeedFactor` but for the toppest card
    public var topStackAlphaSpeedFactor: CGFloat
    
    /// if you want to have a prespective view on you stack you can set this value
    /// to greater that zero, that means spacing factor will be multiplied to this
    /// value for each card
    public var perspectiveRatio: CGFloat
    
    /// If you want to have shadow blew each card set this value to true
    public var shadowEnabled: Bool
    
    /// the shadow color, will be applied if `shadowEnabled` set to true
    public var shadowColor: UIColor
    
    /// the shadow opacity, will be applied if `shadowEnabled` set to true
    public var shadowOpacity: Float
    
    /// the shadow offset, will be applied if `shadowEnabled` set to true
    public var shadowOffset: CGSize
    
    /// the shadow radius, will be applied if `shadowEnabled` set to true
    public var shadowRadius: CGFloat
    
    /// the angle for rotating the stack cards, it works like even-odd
    /// the topest card angle would be zero, the next rotates `stackRotateAngel`
    /// and the next open rotates -`stackRotateAngel` and so on
    public var stackRotateAngel: CGFloat
    
    /// Maximum angle for poping the topest card, starts from zero up to this angle
    public var popAngle: CGFloat
    
    /// Offset for poping the topest card, you can set width or height ratio
    /// cardX -= cardWidth * popOffsetRatio.width * progress
    public var popOffsetRatio: CGSize
    
    /// A point for adjusting the position of card in the stack
    /// for instance if you want to set the stack position to the top you
    /// should set this value to x:0, y:-1, for bottom x:0, y:1,
    /// and set x for left and right, you can combine them too
    public var stackPosition: CGPoint
    
    /// if you want to drop cards from stack by scrolling left to right or top to bottom
    /// you can use this flag, you also need to manually set the conect offset of the collection view
    /// to the content size since you want to scroll from the end of collection view
    /// https://stackoverflow.com/questions/13958543/uicollectionview-scroll-right-to-left-reverse
    public var reverse: Bool
    
    /// Enable this flag if you want to have blur effect, the farest card will be more blury
    public var blurEffectEnabled: Bool
    
    /// Maxium radius for blur effect, will be applied if `blurEffectEnabled` set to true
    public var maxBlurEffectRadius: CGFloat
    
    /// Blur style for blur effect, will be applied if `blurEffectEnabled` set to true
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
        bottomStackAlphaSpeedFactor: CGFloat = 0.9,
        topStackAlphaSpeedFactor: CGFloat = 0.3,
        perspectiveRatio: CGFloat = 0,
        shadowEnabled: Bool = true,
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.1,
        shadowOffset: CGSize = .zero,
        shadowRadius: CGFloat = 10,
        stackRotateAngel: CGFloat = 0,
        popAngle: CGFloat = .pi / 7,
        popOffsetRatio: CGSize = .init(width: -1.3, height: 0.3),
        stackPosition: CGPoint = CGPoint(x: 0, y: -1),
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
        self.shadowRadius = shadowRadius
        self.stackRotateAngel = stackRotateAngel
        self.popAngle = popAngle
        self.popOffsetRatio = popOffsetRatio
        self.stackPosition = stackPosition
        self.reverse = reverse
        self.blurEffectEnabled = blurEffectEnabled
        self.maxBlurEffectRadius = maxBlurEffectRadius
        self.blurEffectStyle = blurEffectStyle
    }
}
