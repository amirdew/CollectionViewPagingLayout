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
    
    
    // MARK: Public functions
    
    func transform(progress: CGFloat) {
        applyScale(progress: progress)
        
        extendTransform(progress: progress)
    }
    
    
    // MARK: Private functions
    
    private func applyShadow(progress: CGFloat) {
        var transform = CGAffineTransform.identity
        var xAdjustment: CGFloat = 0
        var yAdjustment: CGFloat = 0
//        let scaleProgress = options.scaleCurve.computeProgress(min: 0, max: 1, progress: abs(progress))
        var scale = 1 + abs(progress) * 0.3
        //scale = max(scale, options.minScale)
//
//        if options.keepHorizontalSpacingEqual {
//            xAdjustment = ((1 - scale) * scalableView.bounds.width) / 2
//            if progress > 0 {
//                xAdjustment *= -1
//            }
//        }
//
//        if options.keepVerticalSpacingEqual {
//            yAdjustment = ((1 - scale) * scalableView.bounds.height) / 2
//        }
//
//        let translateProgress = options.translationCurve.computeProgress(min: 0, max: 1, progress: abs(progress))
//        let translateX = scalableView.bounds.width * options.translationRatio.x * (translateProgress * (progress < 0 ? -1 : 1)) - xAdjustment
        let translateY = cardView.bounds.height * 0.4
        transform = transform
            .translatedBy(x: 0, y: translateY)
            .scaledBy(x: scale, y: scale)
        cardView.transform = transform
    }
    
    private func applyScale(progress: CGFloat) {
        
    }
    
}


/// Options for `StackTransformView`
public struct StackTransformViewOptions {
    
}
