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
    
    /// If you wish to extend this protocol and add more transforming to it
    /// you can implement this method and do whatever you want
    func extendTransform(progress: CGFloat)
}


public extension StackTransformView {
    
    /// An empty default implementation for extendTransform to make it optional
    func extendTransform(progress: CGFloat) {}
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
        
        switch options.stackPosition {
        case .top, .bottom:
            translateX = -max(0, -progress) * cardView.bounds.width * options.dropOffsetRatio.width
            translateY = cardView.bounds.height * options.spacingFactor * -progress * (options.stackPosition == .bottom ? -1:1)
            yAdjustment = ((scale - 1) * cardView.bounds.height) / 2 // make y equal for all cards

            let stackProgress = progress.interpolate(in: .init(0, CGFloat(options.maxStackSize)))
            let perspectiveProgress  = TransformCurve.easeOut.computeFromLinear(progress: stackProgress)
            yAdjustment += perspectiveProgress * cardView.bounds.height * options.perspectiveRatio
            
            if progress < 0 {
                yAdjustment += translateY * options.dropOffsetRatio.height
            }
            if options.stackPosition == .bottom {
                yAdjustment *= -1
            }
        case .right, .left:
            translateY = -max(0, -progress) * cardView.bounds.height * options.dropOffsetRatio.height
            translateX = cardView.bounds.width * options.spacingFactor * -progress * (options.stackPosition == .right ? -1:1)
            xAdjustment = ((scale - 1) * cardView.bounds.width) / 2 // make x equal for all cards

            let stackProgress = progress.interpolate(in: .init(0, CGFloat(options.maxStackSize)))
            let perspectiveProgress  = TransformCurve.easeOut.computeFromLinear(progress: stackProgress)
            xAdjustment += perspectiveProgress * cardView.bounds.width * options.perspectiveRatio
            
            if progress < 0 {
                xAdjustment += translateX * options.dropOffsetRatio.width
            }
            if options.stackPosition == .right {
                xAdjustment *= -1
            }
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
        
        var angle = -abs(progress).interpolate(out: .init(0, abs(options.dropAngle)))
        if options.dropAngle < 0 {
            angle *= -1
        }
        cardView.transform = cardView.transform.rotated(by: angle)
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
    
    var dropAngle: CGFloat = .pi/7
    
    var dropOffsetRatio: CGSize = .init(width: 1.3, height: 2.2)
    
    var stackPosition: Position = .top
    
    var reverse: Bool = false
}


extension StackTransformViewOptions {
    enum Position {
        case top
        case right
        case bottom
        case left
    }
}
