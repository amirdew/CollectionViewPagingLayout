//
//  GradientView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    // MARK: Properties
    
    override class var layerClass: Swift.AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    override var layer: CAGradientLayer {
        return super.layer as! CAGradientLayer
    }
    
    
    // MARK: Public functions
    
    public func set(colors:[UIColor]) {
        backgroundColor = .clear
        layer.colors = colors.map { $0.cgColor }
    }
    
    public func set(startPoint: CGPoint, endPoint: CGPoint) {
        layer.startPoint = startPoint
        layer.endPoint = endPoint
    }
    
}
