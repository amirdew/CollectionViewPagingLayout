//
//  SnapshotTransformViewOptions.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public struct SnapshotTransformViewOptions {
    
    /// Ratio for computing the size of each piece in the snapshot
    /// width = view.width * `pieceSizeRatio.width`
    var pieceSizeRatio: CGSize = .init(width: 1, height: 1.0/8.0)
    
    /// Ratio for computing the size of each piece in the snapshot
    var piecesCornerRadiusRatio: PiecesValue<CGFloat> = .static(0)
    
    /// Ratio for computing the opacity of each piece in the snapshot
    /// 0 means no opacity change 1 means full opacity change
    var piecesAlphaRatio: PiecesValue<CGFloat> = .static(0)
    
    /// Ratio for the amount of translate for each piece in the snapshot, calculates by each piece size
    /// for instance, if piecesTranslationRatio.x = 0.5 and pieceView.width = 100 then
    /// translateX = 50 for the pieceView
    var piecesTranslationRatio: PiecesValue<CGPoint> = .rowOddEven(.init(x: 0, y: -1), .init(x: -1, y: -1))
    
    /// Ratio for the minimum amount of translate for each piece, calculates like `piecesTranslationRatio`
    var minPiecesTranslationRatio: PiecesValue<CGPoint>? = nil
    
    /// Ratio for the maximum amount of translate for each piece, calculates like `piecesTranslationRatio`
    var maxPiecesTranslationRatio: PiecesValue<CGPoint>? = nil
    
    /// Ratio for computing scale of each piece in the snapshot
    /// Scale = 1 - abs(progress) * `piecesScaleRatio`
    var piecesScaleRatio: PiecesValue<CGSize> = .static(.init(width: 0, height: 1))
    
    /// Ratio for computing scale for the snapshot container
    /// Scale = 1 - abs(progress) * `scaleRatio`
    var containerScaleRatio: CGFloat = 0.25
    
    /// Ratio for the amount of translate for container view, calculates by `targetView` size
    /// for instance, if containerTranslationRatio.x = 0.5 and targetView.width = 100 then
    /// translateX = 50 for the right view and translateX = -50 for the left view
    var containerTranslationRatio: CGPoint = .init(x: 1, y: 0)
    
    /// The minimum amount of translate for container views, calculates like `containerTranslationRatio`
    var containerMinTranslationRatio: CGPoint? = nil
    
    /// The maximum amount of translate for container views, calculates like `containerTranslationRatio`
    var containerMaxTranslationRatio: CGPoint? = nil
    
}


public extension SnapshotTransformViewOptions {
    
    struct PiecePosition {
        let index: Int
        let row: Int
        let column: Int
        let rowCount: Int
        let columnCount: Int
    }
    
    
    enum PiecesValue<Type: MultipliableToCGFloat & MultipliableToSelf> {
        
        // MARK: Cases
        
        case columnBased(Type, reversed: Bool = false)
        case rowBased(Type, reversed: Bool = false)
        case columnOddEven(Type, Type, increasing: Bool = false)
        case rowOddEven(Type, Type, increasing: Bool = false)
        case columnBasedMirror(Type, reversed: Bool = false)
        case rowBasedMirror(Type, reversed: Bool = false)
        case indexBasedCustom([Type])
        case rowBasedCustom([Type])
        case columnBasedCustom([Type])
        case `static`(Type)
        case aggregated([PiecesValue<Type>])
        
        // MARK: Public functions
        
        func getRatio(position: PiecePosition) -> Type {
            switch self {
            case .columnBased(let ratio, let reversed):
                if reversed {
                    return ratio * CGFloat(position.columnCount - position.column - 1)
                } else {
                    return ratio * CGFloat(position.column)
                }
            case .rowBased(let ratio, let reversed):
                if reversed {
                    return ratio * CGFloat(position.rowCount - position.row - 1)
                } else {
                    return ratio * CGFloat(position.row)
                }
                
            case .columnOddEven(let oddRatio, let evenRatio, let increasing):
                return (position.column % 2 == 0 ? evenRatio : oddRatio) * (increasing ? CGFloat(position.column) : 1)
            case .rowOddEven(let oddRatio, let evenRatio, let increasing):
                return (position.row % 2 == 0 ? evenRatio : oddRatio) * (increasing ? CGFloat(position.row) : 1)
            case .indexBasedCustom(let ratios):
                return ratios[position.index % ratios.count]
            case .rowBasedCustom(let ratios):
                return ratios[position.row % ratios.count]
            case .columnBasedCustom(let ratios):
                return ratios[position.column % ratios.count]
            case .static(let ratio):
                return ratio
            case .columnBasedMirror(let ratio, let reversed):
                let middle = Int(position.columnCount / 2)
                if position.columnCount % 2 == 1, position.column == middle {
                    return ratio * 0;
                }
                var colIndex = position.column
                if colIndex >= middle {
                    colIndex -= middle
                } else {
                    colIndex = middle - colIndex
                }
                if reversed {
                    colIndex = middle - colIndex
                }
                return ratio * CGFloat(colIndex) * (position.column > middle ? 1 : -1)
            case .rowBasedMirror(let ratio, let reversed):
                let middle = Int(position.rowCount / 2)
                if position.rowCount % 2 == 1, position.row == middle {
                    return ratio * 0;
                }
                var rowIndex = position.row
                if rowIndex >= middle {
                    rowIndex -= middle
                } else {
                    rowIndex = middle - rowIndex
                }
                if reversed {
                    rowIndex = middle - rowIndex
                }
                return ratio * CGFloat(rowIndex) * (position.row > middle ? 1 : -1)
            case .aggregated(let values):
                guard !values.isEmpty else {
                    fatalError("aggregate array is empty")
                }
                let result = values.map {
                    $0.getRatio(position: position)
                }
                return result.dropFirst().reduce(result.first!, *)
            }
        }
        
    }
}
