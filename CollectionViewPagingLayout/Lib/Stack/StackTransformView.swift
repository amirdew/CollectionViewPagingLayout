//
//  StackTransformView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 21/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

/// A protocol for adding stack transformation effect to `TransformableView`
public protocol StackTransformView: TransformableView {
    
    /// Options for controlling stack effects, see `StackTransformViewOptions.swift`
    var options: StackTransformViewOptions { get }
    
    /// The view to apply scale effect on
    var cardView: UIView { get }
    
    /// The view to apply blur effect on
    var blurViewHost: UIView { get }
    
    /// If you wish to extend this protocol and add more transforming to it
    /// you can implement this method and do whatever you want
    func extendTransform(progress: CGFloat)
}


public extension StackTransformView {
    
    /// An empty default implementation for extendTransform to make it optional
    func extendTransform(progress: CGFloat) {}
    
    /// The default value is the super view of `cardView`
    var blurViewHost: UIView {
        cardView.superview ?? cardView
    }
    
}


public extension StackTransformView where Self: UICollectionViewCell {
    
    /// Default `cardView` for `UICollectionViewCell` is the first subview of
    /// `contentView` or the content view itself in case of no subviews
    var cardView: UIView {
        contentView.subviews.first ?? contentView
    }
}


public extension StackTransformView {
    
    // MARK: Properties
    
    var options: StackTransformViewOptions {
        .init()
    }
    
    
    // MARK: TransformableView
    
    func transform(progress: CGFloat) {
        var progress = progress
        if options.reverse {
            progress *= -1
        }
        applyStyle(progress: progress)
        applyScale(progress: progress)
        applyAlpha(progress: progress)
        applyRotation(progress: progress)
        if #available(iOS 10, *) {
            applyBlurEffect(progress: progress)
        }
        
        extendTransform(progress: progress)
    }
    
    func zPosition(progress: CGFloat) -> Int {
        var zPosition = -Int(round(progress))
        if options.reverse {
            zPosition *= -1
        }
        return zPosition
    }
    
    
    // MARK: Private functions
    
    private func applyStyle(progress: CGFloat) {
        cardView.layer.cornerRadius = options.cornerRadius
        
        guard options.shadowEnabled else {
            return
        }
        let layer = cardView.layer
        layer.shadowColor = options.shadowColor.cgColor
        layer.shadowOffset = options.shadowOffset
        layer.shadowRadius = options.shadowRadius
        layer.shadowOpacity = options.shadowOpacity
    }
    
    private func applyScale(progress: CGFloat) {
        var transform = CGAffineTransform.identity
        var xAdjustment: CGFloat = 0
        var yAdjustment: CGFloat = 0
        
        let scale = 1 - max(progress, 0) * options.scaleFactor
        let translateX: CGFloat
        let translateY: CGFloat
        
        let stackProgress = progress.interpolate(in: .init(0, CGFloat(options.maxStackSize)))
        let perspectiveProgress  = TransformCurve.easeOut.computeFromLinear(progress: stackProgress) * options.perspectiveRatio
        
        switch options.stackPosition {
        case .top, .bottom:
            translateX = 0
            translateY = cardView.bounds.height * options.spacingFactor * -max(progress, 0) * (options.stackPosition == .bottom ? -1 : 1)
            yAdjustment = ((scale - 1) * cardView.bounds.height) / 2 // make y equal for all cards
            yAdjustment += perspectiveProgress * cardView.bounds.height
            
            if options.stackPosition == .bottom {
                yAdjustment *= -1
            }
        case .right, .left:
            translateX = cardView.bounds.width * options.spacingFactor * -max(progress, 0) * (options.stackPosition == .right ? -1 : 1)
            translateY = 0
            xAdjustment = ((scale - 1) * cardView.bounds.width) / 2 // make x equal for all cards
            xAdjustment += perspectiveProgress * cardView.bounds.width
            
            if options.stackPosition == .right {
                xAdjustment *= -1
            }
        }
        if progress < 0 {
            xAdjustment -= cardView.bounds.width * options.popOffsetRatio.width * progress
            yAdjustment -= cardView.bounds.height * options.popOffsetRatio.height * progress
        }
        
        transform = transform
            .translatedBy(x: translateX + xAdjustment, y: translateY + yAdjustment)
            .scaledBy(x: scale, y: scale)
        cardView.transform = transform
    }
    
    private func applyAlpha(progress: CGFloat) {
        cardView.alpha = 1
        
        let floatStackSize = CGFloat(options.maxStackSize)
        if progress >= floatStackSize - 1 {
            let targetCard = floatStackSize - 1
            cardView.alpha = 1 - progress.interpolate(
                in: .init(targetCard, targetCard + options.bottomStackOpacitySpeedFactor)
            )
        } else if progress < 0 {
            cardView.alpha = progress.interpolate(in: .init(-1, -1 + options.topStackOpacitySpeedFactor))
        }
        
        if cardView.alpha > 0 {
            cardView.alpha -= progress * options.opacityReduceFactor
        }
    }
    
    private func applyRotation(progress: CGFloat) {
        guard progress <= 0 else {
            cardView.transform = cardView.transform.rotated(by: 0)
            return
        }
        
        var angle = -abs(progress).interpolate(out: .init(0, abs(options.popAngle)))
        if options.popAngle < 0 {
            angle *= -1
        }
        cardView.transform = cardView.transform.rotated(by: angle)
    }
    
    @available(iOS 10.0, *)
    private func applyBlurEffect(progress: CGFloat) {
        guard options.maxBlurEffectRadius > 0, options.blurEffectEnabled else {
            return
        }
        let blurView: BlurEffectView
        if let view = blurViewHost.subviews.first(where: { $0 is BlurEffectView }) as? BlurEffectView {
            blurView = view
        } else {
            blurView = BlurEffectView(effect: UIBlurEffect(style: .light))
            blurViewHost.fill(with: blurView)
        }
        let radius = max(progress, 0).interpolate(in: .init(0, CGFloat(options.maxStackSize)))
        blurView.setBlurRadius(radius: radius * options.maxBlurEffectRadius)
    }
    
}


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
    
    var shadowRadius: CGFloat = 10
    
    var popAngle: CGFloat = .pi/7
    
    var popOffsetRatio: CGSize = .init(width: -1.3, height: 0.3)
    
    var stackPosition: Position = .top
    
    var reverse: Bool = false
    
    var blurEffectEnabled: Bool = true
    
    var maxBlurEffectRadius: CGFloat = 0.1
}


extension StackTransformViewOptions {
    enum Position {
        case top
        case right
        case bottom
        case left
    }
}
