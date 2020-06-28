//
//  CGPoint.swift
//  PagingLayoutSamples
//
//  Created by Amir on 28/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation

extension CGSize {
    var pair: (CGFloat, CGFloat) {
        (width, height)
    }
    static func by(pair: (CGFloat, CGFloat)) -> CGSize {
        .init(width: pair.0, height: pair.1)
    }
}


extension CGPoint {
    var pair: (CGFloat, CGFloat) {
        (x, y)
    }
    static func by(pair: (CGFloat, CGFloat)) -> CGPoint {
        .init(x: pair.0, y: pair.1)
    }
}
