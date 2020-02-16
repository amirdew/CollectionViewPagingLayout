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


public extension ScaleTransformView where Self: UICollectionViewCell {
    
    // MARK: Properties
    
    var options: ScaleTransformViewOptions {
        .init()
    }
    
    var scalableView: UIView {
        contentView.subviews.first ?? contentView
    }
    
    
    // MARK: Public functions
    
    func transform(progress: CGFloat) {
        // shadow
        if options.shadowEnabled {
            scalableView.layer.shadowColor = options.shadowColor.cgColor
            scalableView.layer.shadowOffset = .init(width: max(options.shadowOffsetMin.width, (1 - abs(progress)) * options.shadowOffsetMax.width),
                                                    height: max(options.shadowOffsetMin.height, (1 - abs(progress)) * options.shadowOffsetMax.height))
            scalableView.layer.shadowRadius = max(options.shadowRadiusMin, (1 - abs(progress)) * options.shadowRadiusMax)
            scalableView.layer.shadowOpacity = max(options.shadowOpacityMin, (1 - abs(Float(progress))) * options.shadowOpacityMax)
        }
        
        // transform
        var transform = CGAffineTransform.identity
        var xAdjustment: CGFloat = 0
        var yAdjustment: CGFloat = 0
        var scale = 1 - abs(progress) * (1 - options.minScale)
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
        
        transform = transform
            .translatedBy(x: scalableView.bounds.width * options.translationRatio.x * progress - xAdjustment,
                          y: scalableView.bounds.height * options.translationRatio.y * abs(progress) - yAdjustment)
            .scaledBy(x: scale, y: scale)
        scalableView.transform = transform
        scalableView.layer.cornerRadius = options.cornerRadius
        
        // extending transform in custom implementation
        extendTransform(progress: progress)
    }
    
    func extendTransform(progress: CGFloat) {}
}


public struct ScaleTransformViewOptions {
    
    // MARK: Properties
    
    var cornerRadius: CGFloat = 50
    var minScale: CGFloat = 0.75
    var translationRatio: CGPoint = .init(x: 0.93, y: 0.36)
    var keepVerticalSpacingEqual: Bool = false
    var keepHorizontalSpacingEqual: Bool = true
    var shadowEnabled: Bool = true
    var shadowColor: UIColor = .black
    var shadowOpacity: Float = 0.6
    var shadowRadiusMin: CGFloat = 2
    var shadowRadiusMax: CGFloat = 13
    var shadowOffsetMin: CGSize = .init(width: 0, height: 2)
    var shadowOffsetMax: CGSize = .init(width: 0, height: 6)
    var shadowOpacityMin: Float = 0.1
    var shadowOpacityMax: Float = 0.1
}
