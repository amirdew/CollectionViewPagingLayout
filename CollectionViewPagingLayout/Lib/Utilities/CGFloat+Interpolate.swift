//
//  CGFloat+Interpolate.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 2/22/20.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

extension CGFloat {
    
    public func interpolate(in inputRange: Range = .init(0, 1), out outputRange: Range = .init(0, 1)) -> CGFloat {
        var current = self
        if current > inputRange.upper {
            current = inputRange.upper
        }
        if current < inputRange.lower {
            current = inputRange.lower
        }
        let progress = abs(current - inputRange.lower) / abs(inputRange.upper - inputRange.lower)
        return outputRange.lower + progress * abs(outputRange.upper - outputRange.lower)
    }
}
