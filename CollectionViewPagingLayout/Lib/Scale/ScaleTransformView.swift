//
//  ScaleTransformView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public protocol ScaleTransformView: TransformableView {
    
    var options: ScaleTransformViewOptions { get }
    var scalableView: UIView { get }
    
    func extendTransform(progress: CGFloat)
}


public extension ScaleTransformView {
    
    func extendTransform(progress: CGFloat) {}
}


public extension ScaleTransformView where Self: UICollectionViewCell {
    
    var scalableView: UIView {
        contentView.subviews.first ?? contentView
    }
}


public extension ScaleTransformView {
    
    // MARK: Properties
    
    var options: ScaleTransformViewOptions {
        .init()
    }
    
    
    // MARK: Public functions
    
    func transform(progress: CGFloat) {
        applyShadow(progress: progress)
        scalableView.layer.cornerRadius = options.cornerRadius
        applyScaleAndTranslation(progress: progress)
        
        // extending transform in custom implementation
        extendTransform(progress: progress)
    }
    
    
    // MARK: Private functions
    
    private func applyShadow(progress: CGFloat) {
        guard options.shadowEnabled else {
            return
        }
        let layer = scalableView.layer
        layer.shadowColor = options.shadowColor.cgColor
        let offset = CGSize(
            width: max(options.shadowOffsetMin.width, (1 - abs(progress)) * options.shadowOffsetMax.width),
            height: max(options.shadowOffsetMin.height, (1 - abs(progress)) * options.shadowOffsetMax.height)
        )
        layer.shadowOffset = offset
        layer.shadowRadius = max(options.shadowRadiusMin, (1 - abs(progress)) * options.shadowRadiusMax)
        layer.shadowOpacity = max(options.shadowOpacityMin, (1 - abs(Float(progress))) * options.shadowOpacityMax)
    }
    
    private func applyScaleAndTranslation(progress: CGFloat) {
        var transform = CGAffineTransform.identity
        var xAdjustment: CGFloat = 0
        var yAdjustment: CGFloat = 0
        let scaleProgress = options.scaleCurve.computeProgress(min: 0, max: 1, progress: abs(progress))
        var scale = 1 - abs(scaleProgress) * (1 - options.minScale)
        scale = max(scale, options.minScale)
        
        if options.keepHorizontalSpacingEqual {
            xAdjustment = ((1 - scale) * scalableView.bounds.width) / 2
            if progress > 0 {
                xAdjustment *= -1
            }
        }
        
        if options.keepVerticalSpacingEqual {
            yAdjustment = ((1 - scale) * scalableView.bounds.height) / 2
        }
        
        let translateProgress = options.translationCurve.computeProgress(min: 0, max: 1, progress: abs(progress))
        let translateX = scalableView.bounds.width * options.translationRatio.x * (translateProgress * (progress < 0 ? -1 : 1)) - xAdjustment
        let translateY = scalableView.bounds.height * options.translationRatio.y * abs(translateProgress) - yAdjustment
        transform = transform
            .translatedBy(x: translateX, y: translateY)
            .scaledBy(x: scale, y: scale)
        scalableView.transform = transform
    }
    
}
