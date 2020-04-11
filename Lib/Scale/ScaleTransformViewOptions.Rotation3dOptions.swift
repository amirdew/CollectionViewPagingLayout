//
//  ScaleTransformViewOptions.Rotation3dOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 27/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public extension ScaleTransformViewOptions {
    
    struct Rotation3dOptions {
        
        // MARK: Properties
        
        /// The angle for rotate side views
        var angle: CGFloat
        
        /// The minimum angle for rotation
        var minAngle: CGFloat
        
        /// The maximum angle for rotation
        var maxAngle: CGFloat
        
        var x: CGFloat
        
        var y: CGFloat
        
        var z: CGFloat
        
        /// `CATransform3D.m34`, read more: https://stackoverflow.com/questions/3881446/meaning-of-m34-of-catransform3d
        var m34: CGFloat
        
        /// `CALayer.isDoubleSided`, read more: https://developer.apple.com/documentation/quartzcore/calayer/1410924-isdoublesided
        var isDoubleSided: Bool = false
        

        // MARK: Lifecycle
        
        public init(angle: CGFloat, minAngle: CGFloat, maxAngle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat, m34: CGFloat) {
            self.angle = angle
            self.minAngle = minAngle
            self.maxAngle = maxAngle
            self.x = x
            self.y = y
            self.z = z
            self.m34 = m34
        }
    }
    
}
