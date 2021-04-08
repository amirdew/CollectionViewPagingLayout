//
//  SnapshotTransformViewOptions.PiecesValue.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 27/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public extension SnapshotTransformViewOptions {
    
    enum PiecesValue<Type: MultipliableToCGFloat & MultipliableToSelf & SummableToCGFloat & SummableToSelf> {

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
        case aggregated([PiecesValue<Type>], (Type, Type) -> Type)
        
        
        // MARK: Public functions
        
        func getRatio(position: PiecePosition) -> Type {
            switch self {
            case .columnBased(let ratio, let reversed):
                return getRowColumnBased(ratio: ratio, count: position.columnCount, current: position.column, reversed: reversed)
            case .rowBased(let ratio, let reversed):
                return getRowColumnBased(ratio: ratio, count: position.rowCount, current: position.row, reversed: reversed)
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
                return getRowColumnBasedMirror(ratio: ratio, count: position.columnCount, current: position.column, reversed: reversed)
            case .rowBasedMirror(let ratio, let reversed):
                return getRowColumnBasedMirror(ratio: ratio, count: position.rowCount, current: position.row, reversed: reversed)
            case .aggregated(let values, let nextPartialResult):
                guard !values.isEmpty else {
                    fatalError("aggregate array is empty")
                }
                let result = values.map {
                    $0.getRatio(position: position)
                }
                return result.dropFirst().reduce(result.first!, nextPartialResult)
            }
        }
        
        
        // MARK: Private functions
        
        private func getRowColumnBased(ratio: Type, count: Int, current: Int, reversed: Bool) -> Type {
            if reversed {
                return ratio * CGFloat(count - current - 1)
            } else {
                return ratio * CGFloat(current)
            }
        }
        
        private func getRowColumnBasedMirror(ratio: Type, count: Int, current: Int, reversed: Bool) -> Type {
            let middle = Int(count / 2)
            if count % 2 == 1, current == middle {
                return ratio * 0
            }
            var index = current
            if index >= middle {
                index -= middle
                if count % 2 == 0 {
                    index += 1
                }
            } else {
                index = middle - index
            }
            if reversed {
                index = middle - index
            }
            var floatIndex = CGFloat(index)
            if count % 2 == 0 {
                floatIndex -= 0.5
            }
            return ratio * floatIndex * (current >= middle ? 1 : -1)
        }
        
    }
}
