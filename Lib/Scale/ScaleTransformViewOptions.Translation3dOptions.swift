//
//  ScaleTransformViewOptions.Translation3dOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 27/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public extension ScaleTransformViewOptions {
    
    struct Translation3dOptions {

        // MARK: Properties
        
        /// The translates(x,y,z) ratios
        /// (translateX = progress * translates.x * targetView.width)
        /// (translateY = progress * translates.y * targetView.height)
        /// (translateZ = progress * translates.z * targetView.width)
        public var translateRatios: (CGFloat, CGFloat, CGFloat)
        
        /// The minimum translate ratios
        public var minTranslateRatios: (CGFloat, CGFloat, CGFloat)
        
        /// The maximum translate ratios
        public var maxTranslateRatios: (CGFloat, CGFloat, CGFloat)
        
        
        // MARK: Lifecycle
        
        public init(
            translateRatios: (CGFloat, CGFloat, CGFloat),
            minTranslateRatios: (CGFloat, CGFloat, CGFloat),
            maxTranslateRatios: (CGFloat, CGFloat, CGFloat)
        ) {
            self.translateRatios = translateRatios
            self.minTranslateRatios = minTranslateRatios
            self.maxTranslateRatios = maxTranslateRatios
        }
    }

}
