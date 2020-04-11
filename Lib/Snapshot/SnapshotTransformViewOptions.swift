//
//  SnapshotTransformViewOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public struct SnapshotTransformViewOptions {
    
    // MARK: Properties
    
    /// Ratio for computing the size of each piece in the snapshot
    /// width = view.width * `pieceSizeRatio.width`
    public var pieceSizeRatio: CGSize
    
    /// Ratio for computing the size of each piece in the snapshot
    public var piecesCornerRadiusRatio: PiecesValue<CGFloat>
    
    /// Ratio for computing the opacity of each piece in the snapshot
    /// 0 means no opacity change 1 means full opacity change
    public var piecesAlphaRatio: PiecesValue<CGFloat>
    
    /// Ratio for the amount of translate for each piece in the snapshot, calculates by each piece size
    /// for instance, if piecesTranslationRatio.x = 0.5 and pieceView.width = 100 then
    /// translateX = 50 for the pieceView
    public var piecesTranslationRatio: PiecesValue<CGPoint>
    
    /// Ratio for the minimum amount of translate for each piece, calculates like `piecesTranslationRatio`
    public var minPiecesTranslationRatio: PiecesValue<CGPoint>?
    
    /// Ratio for the maximum amount of translate for each piece, calculates like `piecesTranslationRatio`
    public var maxPiecesTranslationRatio: PiecesValue<CGPoint>?
    
    /// Ratio for computing scale of each piece in the snapshot
    /// Scale = 1 - abs(progress) * `piecesScaleRatio`
    public var piecesScaleRatio: PiecesValue<CGSize>
    
    /// Ratio for computing scale for the snapshot container
    /// Scale = 1 - abs(progress) * `scaleRatio`
    public var containerScaleRatio: CGFloat
    
    /// Ratio for the amount of translate for container view, calculates by `targetView` size
    /// for instance, if containerTranslationRatio.x = 0.5 and targetView.width = 100 then
    /// translateX = 50 for the right view and translateX = -50 for the left view
    public var containerTranslationRatio: CGPoint
    
    /// The minimum amount of translate for container views, calculates like `containerTranslationRatio`
    public var containerMinTranslationRatio: CGPoint?
    
    /// The maximum amount of translate for container views, calculates like `containerTranslationRatio`
    public var containerMaxTranslationRatio: CGPoint?
    
    
    // MARK: Lifecycle
    
    public init(
        pieceSizeRatio: CGSize = .init(width: 1, height: 1.0 / 8.0),
        piecesCornerRadiusRatio: PiecesValue<CGFloat> = .static(0),
        piecesAlphaRatio: PiecesValue<CGFloat> = .static(0),
        piecesTranslationRatio: PiecesValue<CGPoint> = .rowOddEven(.init(x: 0, y: -1), .init(x: -1, y: -1)),
        minPiecesTranslationRatio: PiecesValue<CGPoint>? = nil,
        maxPiecesTranslationRatio: PiecesValue<CGPoint>? = nil,
        piecesScaleRatio: PiecesValue<CGSize> = .static(.init(width: 0, height: 1)),
        containerScaleRatio: CGFloat = 0.25,
        containerTranslationRatio: CGPoint = .init(x: 1, y: 0),
        containerMinTranslationRatio: CGPoint? = nil,
        containerMaxTranslationRatio: CGPoint? = nil
    ) {
        self.pieceSizeRatio = pieceSizeRatio
        self.piecesCornerRadiusRatio = piecesCornerRadiusRatio
        self.piecesAlphaRatio = piecesAlphaRatio
        self.piecesTranslationRatio = piecesTranslationRatio
        self.minPiecesTranslationRatio = minPiecesTranslationRatio
        self.maxPiecesTranslationRatio = maxPiecesTranslationRatio
        self.piecesScaleRatio = piecesScaleRatio
        self.containerScaleRatio = containerScaleRatio
        self.containerTranslationRatio = containerTranslationRatio
        self.containerMinTranslationRatio = containerMinTranslationRatio
        self.containerMaxTranslationRatio = containerMaxTranslationRatio
    }
}
