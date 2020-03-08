//
//  SnapshotTransformView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 07/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public protocol SnapshotTransformView: TransformableView {
    
    /// The view to apply the effect on
    var targetView: UIView { get }
    
    /// The identifier for snapshot, it won't make a new snapshot if
    /// there is a cashed snapshot with the same identifier
    var identifier: String { get }
    
    /// If you wish to extend this protocol and add more transforming to it
    /// you can implement this method and do whatever you want
    func extendTransform(progress: CGFloat)
}


public extension SnapshotTransformView {
    
    /// An empty default implementation for extendTransform to make it optional
    func extendTransform(progress: CGFloat) {}
    
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
    
//    var options: StackTransformViewOptions {
//        .init()
//    }
    
    
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
        snapshot.transform(progress: progress)
        
        extendTransform(progress: progress)
    }
    
    // MARK: Private functions
    
    private func findSnapshot() -> SnapshotContainerView? {
        let snapshot = targetView.superview?.subviews.first(where: { $0 is SnapshotContainerView }) as? SnapshotContainerView
        if let snapshot = snapshot, snapshot.identifier != identifier {
            snapshot.removeFromSuperview()
            return nil
        }
        return snapshot
    }
    
    private func makeSnapshot() -> SnapshotContainerView? {
        guard let view = SnapshotContainerView(targetView: targetView, pieceSize: .init(width: 60, height: targetView.frame.height / 8), identifier: identifier) else {
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
    
    
    func transform(progress: CGFloat) {
        let scale = 1 - abs(progress) * 0.2
        transform = CGAffineTransform.identity.translatedBy(x: progress * frame.width * 1.3, y: 0).scaledBy(x: scale, y: scale)
        
        let pieceScale = 1 - abs(progress) * 1
        snapshots.forEach {
            $0.transform = CGAffineTransform.identity.scaledBy(x: pieceScale, y: pieceScale)
            $0.layer.cornerRadius = abs(progress) * min($0.frame.height, $0.frame.width)
            $0.layer.masksToBounds = true
        }
    }
}
