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
    var stackOptions: StackTransformViewOptions { get }
    
    /// The view to apply scale effect on
    var cardView: UIView { get }
    
    /// The view to apply blur effect on
    var stackBlurViewHost: UIView { get }
    
    /// the main function for applying transforms
    func applyStackTransform(progress: CGFloat)
}


public extension StackTransformView {
    
    /// The default value is the super view of `cardView`
    var stackBlurViewHost: UIView {
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
    
    var stackOptions: StackTransformViewOptions {
        .init()
    }
    
    
    // MARK: TransformableView
    
    func transform(progress: CGFloat) {
        applyStackTransform(progress: progress)
    }
    
    func zPosition(progress: CGFloat) -> Int {
        var zPosition = -Int(round(progress))
        if stackOptions.reverse {
            zPosition *= -1
        }
        return zPosition
    }
    
    
    // MARK: Public functions
    
    func applyStackTransform(progress: CGFloat) {
        var progress = progress
        if stackOptions.reverse {
            progress *= -1
        }
        applyStyle(progress: progress)
        applyScale(progress: progress)
        applyAlpha(progress: progress)
        applyRotation(progress: progress)
        if #available(iOS 10, *) {
            applyBlurEffect(progress: progress)
        }
    }
    
    
    // MARK: Private functions
    
    private func applyStyle(progress: CGFloat) {
        guard stackOptions.shadowEnabled else {
            return
        }
        let layer = cardView.layer
        layer.shadowColor = stackOptions.shadowColor.cgColor
        layer.shadowOffset = stackOptions.shadowOffset
        layer.shadowRadius = stackOptions.shadowRadius
        layer.shadowOpacity = stackOptions.shadowOpacity
    }
    
    private func applyScale(progress: CGFloat) {
        var transform = CGAffineTransform.identity
        var xAdjustment: CGFloat = 0
        var yAdjustment: CGFloat = 0
        
        var scale = 1 - progress * stackOptions.scaleFactor
        if let minScale = stackOptions.minScale {
            scale = max(minScale, scale)
        }
        if let maxScale = stackOptions.maxScale {
            scale = min(maxScale, scale)
        }
        
        let stackProgress = progress.interpolate(in: .init(0, CGFloat(stackOptions.maxStackSize)))
        let perspectiveProgress = TransformCurve.easeOut.computeFromLinear(progress: stackProgress) * stackOptions.perspectiveRatio
        
    
        var xSpacing = cardView.bounds.width * stackOptions.spacingFactor
        if let max = stackOptions.maxSpacing {
            xSpacing = min(xSpacing, cardView.bounds.width * max)
        }
        let translateX = xSpacing * -max(progress, 0) * -stackOptions.stackPosition.x
        
        var ySpacing = cardView.bounds.height * stackOptions.spacingFactor
        if let max = stackOptions.maxSpacing {
            ySpacing = min(ySpacing, cardView.bounds.height * max)
        }
        let translateY = ySpacing * -max(progress, 0) * -stackOptions.stackPosition.y
        
        yAdjustment = ((scale - 1) * cardView.bounds.height) / 2 // make y equal for all cards
        yAdjustment += perspectiveProgress * cardView.bounds.height
        yAdjustment *= -stackOptions.stackPosition.y
        
        xAdjustment = ((scale - 1) * cardView.bounds.width) / 2 // make x equal for all cards
        xAdjustment += perspectiveProgress * cardView.bounds.width
        xAdjustment *= -stackOptions.stackPosition.x
        
        
        if progress < 0 {
            xAdjustment -= cardView.bounds.width * stackOptions.popOffsetRatio.width * progress
            yAdjustment -= cardView.bounds.height * stackOptions.popOffsetRatio.height * progress
        }
        
        transform = transform
            .translatedBy(x: translateX + xAdjustment, y: translateY + yAdjustment)
            .scaledBy(x: scale, y: scale)
        cardView.transform = transform
    }
    
    private func applyAlpha(progress: CGFloat) {
        cardView.alpha = 1
        
        let floatStackSize = CGFloat(stackOptions.maxStackSize)
        if progress >= floatStackSize - 1 {
            let targetCard = floatStackSize - 1
            cardView.alpha = 1 - progress.interpolate(
                in: .init(targetCard, targetCard + stackOptions.bottomStackAlphaSpeedFactor)
            )
        } else if progress < 0 {
            cardView.alpha = progress.interpolate(in: .init(-1, -1 + stackOptions.topStackAlphaSpeedFactor))
        }
        
        if cardView.alpha > 0, progress >= 0 {
            cardView.alpha -= progress * stackOptions.alphaFactor
        }
        
    }
    
    private func applyRotation(progress: CGFloat) {
        var angle: CGFloat = 0
        if progress <= 0 {
            angle = -abs(progress).interpolate(out: .init(0, abs(stackOptions.popAngle)))
            if stackOptions.popAngle < 0 {
                angle *= -1
            }
        } else {
            let floatAmount = abs(progress - CGFloat(Int(progress)))
            angle = -floatAmount * stackOptions.stackRotateAngel * 2 + stackOptions.stackRotateAngel
            if Int(progress) % 2 == 0 {
                angle *= -1
            }
            if progress < 1 {
                angle += (1 - progress).interpolate(out: .init(0, stackOptions.stackRotateAngel))
            }
        }
        
        cardView.transform = cardView.transform.rotated(by: angle)
    }
    
    @available(iOS 10.0, *)
    private func applyBlurEffect(progress: CGFloat) {
        guard stackOptions.maxBlurEffectRadius > 0, stackOptions.blurEffectEnabled else {
            stackBlurViewHost.subviews.first(where: { $0 is BlurEffectView })?.removeFromSuperview()
            return
        }
        let blurView: BlurEffectView
        if let view = stackBlurViewHost.subviews.first(where: { $0 is BlurEffectView }) as? BlurEffectView {
            blurView = view
        } else {
            blurView = BlurEffectView()
            stackBlurViewHost.fill(with: blurView)
        }
        let radius = max(progress, 0).interpolate(in: .init(0, CGFloat(stackOptions.maxStackSize)))
        blurView.setBlurRadius(effect: UIBlurEffect(style: stackOptions.blurEffectStyle), radius: radius * stackOptions.maxBlurEffectRadius)
    }
    
}
