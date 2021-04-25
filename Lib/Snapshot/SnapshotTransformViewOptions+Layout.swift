//
//  SnapshotTransformViewOptions+Layout.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import UIKit
import Foundation

public extension SnapshotTransformViewOptions {
    enum Layout: String, CaseIterable {
        case grid
        case space
        case chess
        case tiles
        case lines
        case bars
        case puzzle
        case fade
    }

    static func layout(_ layout: Layout) -> Self {
        switch layout {
        case .grid:
            return Self(
                pieceSizeRatio: .init(width: 1.0 / 4.0, height: 1.0 / 10.0),
                piecesCornerRadiusRatio: .static(1),
                piecesAlphaRatio: .static(0),
                piecesTranslationRatio: .aggregated([.rowBasedMirror(CGPoint(x: 0, y: -1.8)), .columnBasedMirror(CGPoint(x: -1.8, y: 0))], +),
                piecesScaleRatio: .static(.init(width: 0.8, height: 0.8)),
                containerScaleRatio: 0.1,
                containerTranslationRatio: .init(x: 0.7, y: 0)
            )
        case .space:
            return Self(
                pieceSizeRatio: .init(width: 1.0 / 3.0, height: 1.0 / 4.0),
                piecesCornerRadiusRatio: .static(0.7),
                piecesAlphaRatio: .aggregated([.rowBasedMirror(0.2), .columnBasedMirror(0.4)], +),
                piecesTranslationRatio: .aggregated([.rowBasedMirror(CGPoint(x: 1, y: -1)), .columnBasedMirror(CGPoint(x: -1, y: 1))], *),
                piecesScaleRatio: .static(.init(width: 0.5, height: 0.5)),
                containerScaleRatio: 0.1,
                containerTranslationRatio: .init(x: 0.7, y: 0)
            )
        case .chess:
            return Self(
                pieceSizeRatio: .init(width: 1.0 / 5.0, height: 1.0 / 10.0),
                piecesCornerRadiusRatio: .static(0.5),
                piecesAlphaRatio: .columnBasedMirror(0.4),
                piecesTranslationRatio: .columnBasedMirror(CGPoint(x: -1, y: 1)),
                piecesScaleRatio: .static(.init(width: 0.5, height: 0.5)),
                containerScaleRatio: 0.1,
                containerTranslationRatio: .init(x: 0.7, y: 0)
            )
        case .tiles:
            return Self(
                pieceSizeRatio: .init(width: 1, height: 1.0 / 10.0),
                piecesCornerRadiusRatio: .static(0),
                piecesAlphaRatio: .static(0.4),
                piecesTranslationRatio: .rowOddEven(CGPoint(x: -0.4, y: 0), CGPoint(x: 0.4, y: 0)),
                piecesScaleRatio: .static(.init(width: 0, height: 0.1)),
                containerScaleRatio: 0.1,
                containerTranslationRatio: .init(x: 1, y: 0)
            )
        case .lines:
            return Self(
                pieceSizeRatio: .init(width: 1, height: 1.0 / 16.0),
                piecesCornerRadiusRatio: .static(0),
                piecesAlphaRatio: .static(0.4),
                piecesTranslationRatio: .rowOddEven(CGPoint(x: -0.15, y: 0), CGPoint(x: 0.15, y: 0)),
                piecesScaleRatio: .static(.init(width: 0.6, height: 0.96)),
                containerScaleRatio: 0.1,
                containerTranslationRatio: .init(x: 0.8, y: 0)
            )
        case .bars:
            return Self(
                pieceSizeRatio: .init(width: 1.0 / 10.0, height: 1),
                piecesCornerRadiusRatio: .static(1.2),
                piecesAlphaRatio: .static(0.4),
                piecesTranslationRatio: .columnOddEven(CGPoint(x: 0, y: -0.1), CGPoint(x: 0, y: 0.1)),
                piecesScaleRatio: .static(.init(width: 0.2, height: 0.6)),
                containerScaleRatio: 0.1,
                containerTranslationRatio: .init(x: 1, y: 0)
            )
        case .puzzle:
            return Self(
                pieceSizeRatio: .init(width: 1.0 / 4.0, height: 1.0 / 10.0),
                piecesCornerRadiusRatio: .static(0),
                piecesAlphaRatio: .aggregated([.rowOddEven(0.2, 0), .columnOddEven(0, 0.2)], +),
                piecesTranslationRatio: .rowOddEven(CGPoint(x: -0.15, y: 0), CGPoint(x: 0.15, y: 0)),
                piecesScaleRatio: .columnOddEven(.init(width: 0.1, height: 0.4), .init(width: 0.4, height: 0.1)),
                containerScaleRatio: 0.2,
                containerTranslationRatio: .init(x: 1, y: 0)
            )
        case .fade:
            return Self(
                pieceSizeRatio: .init(width: 1, height: 1.0 / 10.0),
                piecesCornerRadiusRatio: .static(0.1),
                piecesAlphaRatio: .rowBased(0.1),
                piecesTranslationRatio: .rowBasedMirror(CGPoint(x: 0, y: 0.1)),
                piecesScaleRatio: .rowBasedMirror(.init(width: 0.05, height: 0.1)),
                containerScaleRatio: 0.7,
                containerTranslationRatio: .init(x: 1.9, y: 0)
            )
        }
    }
}
