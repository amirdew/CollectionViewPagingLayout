//
//  SnapshotTransformViewOptions.PiecesValue.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 27/03/2020.
//

import UIKit

public extension SnapshotTransformViewOptions {
    
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
