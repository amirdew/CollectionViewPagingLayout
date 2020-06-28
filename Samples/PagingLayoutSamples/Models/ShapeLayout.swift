//
//  ShapeLayout.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 2/16/20.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

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

extension ShapeLayout {
    static let scaleLayouts: [ShapeLayout] = [
        .scaleInvertedCylinder,
        .scaleCylinder,
        .scaleCoverFlow,
        .scaleRotary,
        .scaleLinear,
        .scaleEaseIn,
        .scaleEaseOut,
        .scaleBlur
    ]
    
    static let stackLayouts: [ShapeLayout] = [
        .stackVortex,
        .stackRotary,
        .stackTransparent,
        .stackBlur,
        .stackReverse,
        .stackPerspective
    ]
    
    static let snapshotLayouts: [ShapeLayout] = [
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

extension Array where Element == ShapeLayout {
    static var scale: [ShapeLayout] { ShapeLayout.scaleLayouts }
    static var stack: [ShapeLayout] { ShapeLayout.stackLayouts }
    static var snapshot: [ShapeLayout] { ShapeLayout.snapshotLayouts }
}
