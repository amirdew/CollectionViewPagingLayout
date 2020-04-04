//
//  SnapshotShapeCollectionViewCells.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 07/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class GridSnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions = .init(
        pieceSizeRatio: .init(width: 1.0/4.0, height: 1.0/8.0),
        piecesCornerRadiusRatio: .static(1),
        piecesAlphaRatio: .static(0),
        piecesTranslationRatio: .aggregated([.rowBasedMirror(CGPoint(x: 0, y: -1.8)), .columnBasedMirror(CGPoint(x: -1.8, y: 0))], +),
        piecesScaleRatio: .static(.init(width: 0.8, height: 0.8)),
        containerScaleRatio: 0.1,
        containerTranslationRatio: .init(x: 0.7, y: 0)
    )
}


class SpaceSnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions = .init(
        pieceSizeRatio: .init(width: 1.0/3.0, height: 1.0/4.0),
        piecesCornerRadiusRatio: .static(0.7),
        piecesAlphaRatio: .aggregated([.rowBasedMirror(0.2), .columnBasedMirror(0.4)], +),
        piecesTranslationRatio: .aggregated([.rowBasedMirror(CGPoint(x: 1, y: -1)), .columnBasedMirror(CGPoint(x: -1, y: 1))], *),
        piecesScaleRatio: .static(.init(width: 0.5, height: 0.5)),
        containerScaleRatio: 0.1,
        containerTranslationRatio: .init(x: 0.7, y: 0)
    )
}


class ChessSnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions = .init(
        pieceSizeRatio: .init(width: 1.0/5.0, height: 1.0/8.0),
        piecesCornerRadiusRatio: .static(0.5),
        piecesAlphaRatio: .columnBasedMirror(0.4),
        piecesTranslationRatio: .columnBasedMirror(CGPoint(x: -1, y: 1)),
        piecesScaleRatio: .static(.init(width: 0.5, height: 0.5)),
        containerScaleRatio: 0.1,
        containerTranslationRatio: .init(x: 0.7, y: 0)
    )
}


class TilesSnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions = .init(
        pieceSizeRatio: .init(width: 1, height: 1.0/8.0),
        piecesCornerRadiusRatio: .static(0),
        piecesAlphaRatio: .static(0.4),
        piecesTranslationRatio: .rowOddEven(CGPoint(x: -0.4, y: 0), CGPoint(x: 0.4, y: 0)),
        piecesScaleRatio: .static(.init(width: 0, height: 0.1)),
        containerScaleRatio: 0.1,
        containerTranslationRatio: .init(x: 1, y: 0)
    )
}


class LinesSnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions = .init(
        pieceSizeRatio: .init(width: 1, height: 1.0/16.0),
        piecesCornerRadiusRatio: .static(0),
        piecesAlphaRatio: .static(0.4),
        piecesTranslationRatio: .rowOddEven(CGPoint(x: -0.15, y: 0), CGPoint(x: 0.15, y: 0)),
        piecesScaleRatio: .static(.init(width: 0.1, height: 0.96)),
        containerScaleRatio: 0.1,
        containerTranslationRatio: .init(x: 1, y: 0)
    )
}


class BarsSnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions = .init(
        pieceSizeRatio: .init(width: 1.0/10.0, height: 1),
        piecesCornerRadiusRatio: .static(1.2),
        piecesAlphaRatio: .static(0.4),
        piecesTranslationRatio: .columnOddEven(CGPoint(x: 0, y: -0.1), CGPoint(x: 0, y: 0.1)),
        piecesScaleRatio: .static(.init(width: 0.2, height: 0.6)),
        containerScaleRatio: 0.1,
        containerTranslationRatio: .init(x: 1, y: 0)
    )
}


class PuzzleSnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions = .init(
        pieceSizeRatio: .init(width: 1.0/4.0, height: 1.0/8.0),
        piecesCornerRadiusRatio: .static(0),
        piecesAlphaRatio: .aggregated([.rowOddEven(0.2, 0), .columnOddEven(0, 0.2)], +),
        piecesTranslationRatio: .rowOddEven(CGPoint(x: -0.15, y: 0), CGPoint(x: 0.15, y: 0)),
        piecesScaleRatio: .columnOddEven(.init(width: 0.1, height: 0.4), .init(width: 0.4, height: 0.1)),
        containerScaleRatio: 0.2,
        containerTranslationRatio: .init(x: 1, y: 0)
    )
}


class FadeSnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions = .init(
        pieceSizeRatio: .init(width: 1, height: 1.0/12.0),
        piecesCornerRadiusRatio: .static(0.1),
        piecesAlphaRatio: .rowBased(0.1),
        piecesTranslationRatio: .rowBasedMirror(CGPoint(x: 0, y: 0.1)),
        piecesScaleRatio: .rowBasedMirror(.init(width: 0.05, height: 0.1)),
        containerScaleRatio: 0.7,
        containerTranslationRatio: .init(x: 1.9, y: 0)
    )
}
