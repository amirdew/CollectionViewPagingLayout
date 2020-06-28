//
//  TransformCurve+Name.swift
//  PagingLayoutSamples
//
//  Created by Amir on 28/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import CollectionViewPagingLayout

extension TransformCurve {
    
    static var all: [TransformCurve] {
        [.linear, .easeIn, .easeOut]
    }
    
    static func by(name: String) -> TransformCurve? {
        switch name.lowercased() {
        case "EaseIn".lowercased():
            return .easeIn
        case "EaseOut".lowercased():
            return .easeOut
        case "Linear".lowercased():
            return .linear
        default:
            return nil
        }
    }
    
    var name: String {
        switch self {
        case .easeIn:
            return "EaseIn"
        case .easeOut:
            return "EaseOut"
        case .linear:
            return "Linear"
        }
    }
}
