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
    var snapshotOptions: SnapshotTransformViewOptions { get }
    
    /// The view to apply the effect on
    var targetView: UIView { get }
    
    /// A unique identifier for the snapshot, a new snapshot won't be made if
    /// there is a cashed snapshot with the same identifier
    var snapshotIdentifier: String { get }
    
    /// the function for getting the cached snapshot or make a new one and cache it
    func getSnapshot() -> SnapshotContainerView?
    
    /// the main function for applying transforms on the snapshot
    func applySnapshotTransform(snapshot: SnapshotContainerView, progress: CGFloat)

    /// Check if the snapshot can be reused
    func canReuse(snapshot: SnapshotContainerView) -> Bool
}


public extension SnapshotTransformView where Self: UICollectionViewCell {
    
    /// Default `targetView` for `UICollectionViewCell` is the first subview of
    /// `contentView` or the content view itself in case of no subviews
    var targetView: UIView {
        contentView.subviews.first ?? contentView
    }
    
    /// Default `identifier` for `UICollectionViewCell` is it's index
    /// if you have the same content with different indexes (like an infinite list)
    /// you should override this and provide a content-based identifier
    var snapshotIdentifier: String {
        var collectionView: UICollectionView?
        var superview = self.superview
        while superview != nil {
            if let view = superview as? UICollectionView {
                collectionView = view
                break
            }
            superview = superview?.superview
        }
        var identifier = "\(collectionView?.indexPath(for: self) ?? IndexPath())"

        if let scrollView = targetView as? UIScrollView {
            identifier.append("\(scrollView.contentOffset)")
        }

        if let scrollView = targetView.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            identifier.append("\(scrollView.contentOffset)")
        }
        
        return identifier
    }

    /// Default implementation only compares the size of snapshot with the view
    func canReuse(snapshot: SnapshotContainerView) -> Bool {
        snapshot.snapshotSize == targetView.bounds.size
    }
}


public extension SnapshotTransformView {
    
    // MARK: Properties
    
    var snapshotOptions: SnapshotTransformViewOptions {
        .init()
    }
    
    // MARK: TransformableView
    
    func transform(progress: CGFloat) {
        guard let snapshot = getSnapshot() else {
            return
        }
        applySnapshotTransform(snapshot: snapshot, progress: progress)
    }
    
    
    // MARK: Public functions
    
    func getSnapshot() -> SnapshotContainerView? {
        findSnapshot() ?? makeSnapshot()
    }
    
    func applySnapshotTransform(snapshot: SnapshotContainerView, progress: CGFloat) {
        if progress == 0 {
            targetView.transform = .identity
            snapshot.alpha = 0
        } else {
            snapshot.alpha = 1
            // hide the original view, we apply transform on the snapshot
            targetView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -2 * UIScreen.main.bounds.height)
        }
        snapshot.transform(progress: progress, options: snapshotOptions)
    }
    
    
    // MARK: Private functions

    private func hideOtherSnapshots() {
        targetView.superview?.subviews.filter { $0 is SnapshotContainerView }.forEach {
            guard let snapshot = $0 as? SnapshotContainerView else { return }
            if snapshot.identifier != snapshotIdentifier {
            	snapshot.alpha = 0
            }
        }
    }

    private func findSnapshot() -> SnapshotContainerView? {
        hideOtherSnapshots()
        
        let snapshot = targetView.superview?.subviews.first {
            ($0 as? SnapshotContainerView)?.identifier == snapshotIdentifier
        } as? SnapshotContainerView

        if let snapshot = snapshot, snapshot.pieceSizeRatio != snapshotOptions.pieceSizeRatio {
            snapshot.removeFromSuperview()
            return nil
        }
        if let snapshot = snapshot, !canReuse(snapshot: snapshot) {
            snapshot.removeFromSuperview()
            return nil
        }
        snapshot?.alpha = 1
        return snapshot
    }
    
    private func makeSnapshot() -> SnapshotContainerView? {
        targetView.superview?.subviews.first {
            ($0 as? SnapshotContainerView)?.identifier == snapshotIdentifier
        }?
        .removeFromSuperview()

        guard let view = SnapshotContainerView(targetView: targetView,
                                               pieceSizeRatio: snapshotOptions.pieceSizeRatio,
                                               identifier: snapshotIdentifier)
        else { return nil }

        targetView.superview?.insertSubview(view, aboveSubview: targetView)
        targetView.equalSize(to: view)
        targetView.center(to: view)
        return view
    }
    
}


private extension SnapshotContainerView {

    func transform(progress: CGFloat, options: SnapshotTransformViewOptions) {
        let scale = max(1 - abs(progress) * options.containerScaleRatio, 0)
        var translateX = progress * frame.width * options.containerTranslationRatio.x
        var translateY = progress * frame.height * options.containerTranslationRatio.y
        if let min = options.containerMinTranslationRatio {
            translateX = max(translateX, frame.width * min.x)
            translateY = max(translateX, frame.width * min.y)
        }
        if let max = options.containerMaxTranslationRatio {
            translateX = min(translateX, frame.width * max.x)
            translateY = min(translateY, frame.height * max.y)
        }
        
        transform = CGAffineTransform.identity
            .translatedBy(x: translateX,
                          y: translateY)
            .scaledBy(x: scale, y: scale)
        var sizeRatioRow = options.pieceSizeRatio.height
        if abs(sizeRatioRow) < 0.01 {
            sizeRatioRow = 0.01
        }
        var sizeRatioColumn = options.pieceSizeRatio.width
        if abs(sizeRatioColumn) < 0.01 {
            sizeRatioColumn = 0.01
        }
        let rowCount = Int(1.0 / sizeRatioRow)
        let columnCount = Int(1.0 / sizeRatioColumn)
        
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
            let minPieceTransform = options.minPiecesTranslationRatio?.getRatio(position: position)
            let maxPieceTransform = options.maxPiecesTranslationRatio?.getRatio(position: position)
            var translateX = pieceTransform.x * view.frame.width
            var translateY = pieceTransform.y * view.frame.height
            
            if let min = minPieceTransform {
                translateX = max(translateX, view.frame.width * min.x)
                translateY = max(translateY, view.frame.height * min.y)
            }
            if let max = maxPieceTransform {
                translateX = min(translateX, view.frame.width * max.x)
                translateY = min(translateY, view.frame.height * max.y)
            }
            
            view.transform = CGAffineTransform.identity
                .translatedBy(x: translateX, y: translateY)
                .scaledBy(x: max(0, 1 - pieceScale.width), y: max(0, 1 - pieceScale.height))
            view.alpha = 1 - options.piecesAlphaRatio.getRatio(position: position) * abs(progress)
            view.layer.cornerRadius = options.piecesCornerRadiusRatio.getRatio(position: position) * abs(progress) * min(view.frame.height, view.frame.width)
            view.layer.masksToBounds = true
        }
    }
}
