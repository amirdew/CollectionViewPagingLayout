//
//  ShapeLayout+SnapshotOptions.swift
//  PagingLayoutSamples
//
//  Created by Amir on 27/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import CollectionViewPagingLayout

extension ShapeLayout {
    var snapshotOptions: SnapshotTransformViewOptions? {
        switch self {
        case .snapshotGrid:
            return .layout(.grid)
        case .snapshotSpace:
            return .layout(.space)
        case .snapshotChess:
            return .layout(.chess)
        case .snapshotTiles:
            return .layout(.tiles)
        case .snapshotLines:
            return .layout(.lines)
        case .snapshotBars:
            return .layout(.bars)
        case .snapshotPuzzle:
            return .layout(.puzzle)
        case .snapshotFade:
            return .layout(.fade)
        default:
            return nil
        }
        
    }
}
