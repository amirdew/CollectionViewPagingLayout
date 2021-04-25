//
//  ShapeLayout+ScaleOptions.swift
//  PagingLayoutSamples
//
//  Created by Amir on 27/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import CollectionViewPagingLayout

extension ShapeLayout {
    var scaleOptions: ScaleTransformViewOptions? {
        switch self {
        case .scaleBlur:
            return .layout(.blur)
        case .scaleLinear:
            return .layout(.linear)
        case .scaleEaseIn:
            return .layout(.easeIn)
        case .scaleEaseOut:
            return .layout(.easeOut)
        case .scaleRotary:
            return .layout(.rotary)
        case .scaleCylinder:
            return .layout(.cylinder)
        case .scaleInvertedCylinder:
            return .layout(.invertedCylinder)
        case .scaleCoverFlow:
            return .layout(.coverFlow)
        default:
            return nil
        }
    }
}
