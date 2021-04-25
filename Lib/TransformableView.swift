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
    
    /// The view for detecting gestures
    ///
    /// If you want to handle it manually return `nil`
    var selectableView: UIView? { get }
    
    /// Sends a float value based on the position of the view (cell)
    /// if the view is in the center of CollectionView it sends 0
    /// the value could be negative or positive and that represents the distance to the center of your CollectionView.
    /// for instance `1` means the distance between the center of the cell and the center of your CollectionView
    /// is equal to your CollectionView width.
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
        contentView.subviews.first ?? contentView
    }
}


public extension UICollectionViewCell {
    /// This method transfers the event to `selectableView`
    /// this is necessary since cells are on top of each other and they fill the whole collectionView frame
    /// Without this, only the first visible cell is selectable
    // swiftlint:disable:next override_in_extension
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let view = (self as? TransformableView)?.selectableView {
            return view.hitTest(convert(point, to: view), with: event)
        }
        return super.hitTest(point, with: event)
    }
}
