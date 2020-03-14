//
//  SnapshotTransformView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 07/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public protocol SnapshotTransformView: TransformableView {
    
    /// Options for controlling the effects, see `SnapshotTransformViewOptions.swift`
    var options: SnapshotTransformViewOptions { get }
    
    /// The view to apply the effect on
    var targetView: UIView { get }
    
    /// The identifier for snapshot, it won't make a new snapshot if
    /// there is a cashed snapshot with the same identifier
    var identifier: String { get }
    
    /// If you wish to extend this protocol and add more transformations to it
    /// you can implement this method and do whatever you want
    func extendTransform(snapshot: SnapshotContainerView, progress: CGFloat)
}


public extension SnapshotTransformView {
    
    /// An empty default implementation for extendTransform to make it optional
    func extendTransform(snapshot: SnapshotContainerView, progress: CGFloat) {}
    
}


public extension SnapshotTransformView where Self: UICollectionViewCell {
    
    /// Default `targetView` for `UICollectionViewCell` is the first subview of
    /// `contentView` or the content view itself in case of no subviews
    var targetView: UIView {
        contentView.subviews.first ?? contentView
    }
    
    /// Default `identifier` for `UICollectionViewCell` is it's index
    /// if you have the same content with different indexes (like infinite list)
    /// you should override this and provide a content-based identifier
    var identifier: String {
        var collectionView: UICollectionView? = nil
        var superview = self.superview
        while superview != nil {
            if let view = superview as? UICollectionView {
                collectionView = view
                break
            }
            superview = superview?.superview
        }
        return "\(collectionView?.indexPath(for: self) ?? IndexPath())"
    }
}


public extension SnapshotTransformView {
    
    // MARK: Properties
    
    var options: SnapshotTransformViewOptions {
        .init()
    }
    
    // MARK: TransformableView
    
    func transform(progress: CGFloat) {
        targetView.layer.cornerRadius = 30
        guard let snapshot = findSnapshot() ?? makeSnapshot() else {
            return
        }
        if progress == 0 {
            targetView.transform = .identity
            snapshot.alpha = 0
        } else {
            snapshot.alpha = 1
            // hide the original view, we apply transform on the snapshot
            targetView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -UIScreen.main.bounds.height)
        }
        snapshot.transform(progress: progress, options: options)
        
        extendTransform(snapshot: snapshot, progress: progress)
    }
    
    // MARK: Private functions
    
    private func findSnapshot() -> SnapshotContainerView? {
        let snapshot = targetView.superview?.subviews.first(where: { $0 is SnapshotContainerView }) as? SnapshotContainerView
        if let snapshot = snapshot, (snapshot.identifier != identifier || snapshot.snapshotSize != targetView.bounds.size) {
            snapshot.removeFromSuperview()
            return nil
        }
        return snapshot
    }
    
    private func makeSnapshot() -> SnapshotContainerView? {
        guard let view = SnapshotContainerView(targetView: targetView, pieceSizeRatio: options.pieceSizeRatio, identifier: identifier) else {
            return nil
        }
        targetView.superview?.insertSubview(view, aboveSubview: targetView)
        targetView.equalSize(to: view)
        targetView.center(to: view)
        return view
    }
    
}


private extension SnapshotContainerView {
    
    //    func transform(progress: CGFloat) {
    //        let scale = 1 - abs(progress) * 0.2
    //        transform = CGAffineTransform.identity.translatedBy(x: progress * frame.width * 1.3, y: 0).scaledBy(x: scale, y: scale)
    //        let pieceScale = 1 - abs(progress) * 1
    //        snapshots.forEach {
    //            $0.transform = CGAffineTransform.identity.scaledBy(x: pieceScale, y: pieceScale)
    //            $0.layer.cornerRadius = abs(progress) * min($0.frame.height, $0.frame.width)
    //            $0.layer.masksToBounds = true
    //        }
    //    }
    
    
    func transform(progress: CGFloat, options: SnapshotTransformViewOptions) {
        let scale = 1 - abs(progress) * options.containerScaleRatio
        transform = CGAffineTransform.identity
            .translatedBy(x: progress * frame.width * options.containerTranslationRatio.x,
                          y: progress * frame.height * options.containerTranslationRatio.y)
            .scaledBy(x: scale, y: scale)
        
        let rowCount = Int(1.0 / options.pieceSizeRatio.height)
        let columnCount = Int(1.0 / options.pieceSizeRatio.width)
        snapshots.enumerated().forEach { index, view in
            let position = SnapshotTransformViewOptions.PiecePosition(
                index: index,
                row: Int(index / columnCount),
                column: Int(index % columnCount),
                rowCount: rowCount,
                columnCount: columnCount
            )

            let pieceScale = abs(progress) * options.piecesScaleRatio.getRatio(position: position)
            let pieceTransform = options.piecesTranslationRatio.getRatio(position: position) * abs(progress)
            
            view.transform = CGAffineTransform.identity
                .translatedBy(x: pieceTransform.x, y: pieceTransform.y)
                .scaledBy(x: 1 - pieceScale.width, y: 1 - pieceScale.height)
            view.layer.cornerRadius = options.piecesCornerRadiusRatio.getRatio(position: position) * abs(progress) * min(view.frame.height, view.frame.width)
            view.layer.masksToBounds = true
        }
    }
}



public struct SnapshotTransformViewOptions {
    
    /// Ratio for computing the size of each piece in the snapshot
    /// width = view.width * `pieceSizeRatio.width`
    var pieceSizeRatio: CGSize = .init(width: 1.0/5.0, height: 1.0/8.0)
    
    var piecesCornerRadiusRatio: PiecesValue<CGFloat> = .static(0)
    
    var piecesTranslationRatio: PiecesValue<CGPoint> = .rowOddEven(.init(x: 70, y: 0), .init(x: -70, y: 0))
    
    /// Ratio for computing scale of each piece in the snapshot
    /// Scale = 1 - abs(progress) * `piecesScaleRatio`
    var piecesScaleRatio: PiecesValue<CGSize> = .static(.init(width: 0, height: 1))
    
    /// Ratio for computing scale for the snapshot container
    /// Scale = 1 - abs(progress) * `scaleRatio`
    var containerScaleRatio: CGFloat = 0.25
    
    /// Ratio for the amount of translate for container view, calculates by `targetView` size
    /// for instance, if containerTranslationRatio.x = 0.5 and targetView.width = 100 then
    /// translateX = 50 for the right view and translateX = -50 for the left view
    var containerTranslationRatio: CGPoint = .init(x: 1.8, y: 0)
    
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
                return ratio * (rowIndex > middle ? 1 : -1)

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

public protocol MultipliableToCGFloat {
    static func * (rhs: Self, lhs: CGFloat) -> Self
    static func * (rhs: CGFloat, lhs: Self) -> Self
}

public protocol MultipliableToSelf {
    static func * (rhs: Self, lhs: Self) -> Self
}

extension CGFloat: MultipliableToCGFloat, MultipliableToSelf {}

extension CGPoint: MultipliableToCGFloat, MultipliableToSelf {
    public static func * (rhs: CGFloat, lhs: CGPoint) -> CGPoint {
        lhs * rhs
    }
    public static func * (rhs: CGPoint, lhs: CGFloat) -> CGPoint {
        CGPoint(x: rhs.x * lhs, y: rhs.y * lhs)
    }
    public static func * (rhs: CGPoint, lhs: CGPoint) -> CGPoint {
        CGPoint(x: rhs.x * lhs.x, y: rhs.y * lhs.y)
    }
}

extension CGSize: MultipliableToCGFloat, MultipliableToSelf {
    public static func * (rhs: CGFloat, lhs: CGSize) -> CGSize {
        lhs * rhs
    }
    public static func * (rhs: CGSize, lhs: CGFloat) -> CGSize {
        CGSize(width: rhs.width * lhs, height: rhs.height * lhs)
    }
    public static func * (rhs: CGSize, lhs: CGSize) -> CGSize {
        CGSize(width: rhs.width * lhs.width, height: rhs.height * lhs.height)
    }
}
