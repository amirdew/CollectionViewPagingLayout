//
//  TransformableView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/26/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

public protocol TransformableView {
    
    /// The view for detecting tap gesture
    /// when you call `CollectionViewPagingLayout.configureTapOnCollectionView()`
    /// a tap gesture will be added to the CollectionView and when the user tap on it
    /// it checks if the tap location was in this view frame it will trigger
    /// `CollectionViewPagingLayoutDelegate.collectionViewPagingLayout(_ layout:, didSelectItemAt indexPath:)`
    var selectableView: UIView? { get }
    
    /// Sends a float value based on the position of the view (cell)
    /// if the view is in the center of CollectionView it sends 0
    ///
    /// - Parameter progress: the interpolated progress for the cell view
    func transform(progress: CGFloat)
    
    /// Optional function for providing the Z index(position) of the cell view
    /// As defined as an extension the default value of zIndex is Int(-abs(round(progress)))
    ///
    /// - Parameter progress: the interpolated progress for the cell view
    /// - Returns: the z index(position)
    func zPosition(progress: CGFloat) -> Int
}


public extension TransformableView {
    
    /// Defining the default value of zIndex
    func zPosition(progress: CGFloat) -> Int {
        Int(-abs(round(progress)))
    }
}


public extension TransformableView where Self: UICollectionViewCell {
    
    /// Default `selectableView` for `UICollectionViewCell` is the first subview of
    /// `contentView` or the content view itself if there is no subview
    var selectableView: UIView? {
        contentView.subviews.first
    }
}

