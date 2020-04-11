//
//  TransformCurve.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 2/16/20.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

/// Curve function type for transforming
public enum TransformCurve {
    case linear
    case easeIn
    case easeOut
}


public extension TransformCurve {

    /// Converting linear progress to curve progress
    /// input and output are between 0 and 1
    ///
    /// - Parameter progress: the current linear progress
    /// - Returns: Curved progress based on self
    func computeFromLinear(progress: CGFloat) -> CGFloat {
        switch self {
        case .linear:
            return progress
        case .easeIn, .easeOut:
            let logValue = progress * 9
            let value: CGFloat
            if self == .easeOut {
                value = 1 - log10(1 + (9 - logValue))
            } else {
                value = log10(1 + logValue)
            }
            return value
        }
    }
    
}
