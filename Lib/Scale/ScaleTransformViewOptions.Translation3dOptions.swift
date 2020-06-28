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
        
        /// The translates(x,y,z) ratios (translateX = progress * translates.x)
        public var translateRatios: (CGFloat, CGFloat, CGFloat)
        
        /// The minimum translate values
        public var minTranslates: (CGFloat, CGFloat, CGFloat)
        
        /// The maximum translate values
        public var maxTranslates: (CGFloat, CGFloat, CGFloat)
        
        
        // MARK: Lifecycle
        
        public init(
            translateRatios: (CGFloat, CGFloat, CGFloat),
            minTranslates: (CGFloat, CGFloat, CGFloat),
            maxTranslates: (CGFloat, CGFloat, CGFloat)
        ) {
            self.translateRatios = translateRatios
            self.minTranslates = minTranslates
            self.maxTranslates = maxTranslates
        }
    }
    
}
