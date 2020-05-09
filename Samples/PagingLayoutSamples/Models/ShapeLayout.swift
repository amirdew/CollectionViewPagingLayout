//
//  ShapeLayout.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 2/16/20.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

enum ShapeLayout {
    case scaleInvertedCylinder
    case scaleCylinder
    case scaleCoverFlow
    case scaleRotary
    case scaleLinear
    case scaleEaseIn
    case scaleEaseOut
    case scaleBlur
    
    case stackTransparent
    case stackPerspective
    case stackRotary
    case stackVortex
    case stackReverse
    case stackBlur
    
    case snapshotGrid
    case snapshotSpace
    case snapshotChess
    case snapshotTiles
    case snapshotLines
    case snapshotBars
    case snapshotPuzzle
    case snapshotFade
}

extension Array where Element == ShapeLayout {
    
    static let scale: [ShapeLayout] = [
        .scaleInvertedCylinder,
        .scaleCylinder,
        .scaleCoverFlow,
        .scaleRotary,
        .scaleLinear,
        .scaleEaseIn,
        .scaleEaseOut,
        .scaleBlur
    ]
    
    static let stack: [ShapeLayout] = [
        .stackVortex,
        .stackRotary,
        .stackTransparent,
        .stackBlur,
        .stackReverse,
        .stackPerspective
    ]
    
    static var snapshot: [ShapeLayout] = [
        .snapshotBars,
        .snapshotFade,
        .snapshotGrid,
        .snapshotChess,
        .snapshotLines,
        .snapshotSpace,
        .snapshotTiles,
        .snapshotPuzzle
    ]
}
