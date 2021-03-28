//
//  ShapeLayout+StackOptions.swift
//  PagingLayoutSamples
//
//  Created by Amir on 27/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import CollectionViewPagingLayout

extension ShapeLayout {
    var stackOptions: StackTransformViewOptions? {
        switch self {
        case .stackTransparent:
            return .layout(.transparent)
        case .stackPerspective:
            return .layout(.perspective)
        case .stackRotary:
            return .layout(.rotary)
        case .stackVortex:
            return .layout(.vortex)
        case .stackReverse:
            return .layout(.reverse)
        case .stackBlur:
            return .layout(.blur)
        default:
            return nil
        }
    }
}
