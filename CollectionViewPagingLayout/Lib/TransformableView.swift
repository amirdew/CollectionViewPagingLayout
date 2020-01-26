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
    
    /// Sends a float value based on the position of the view (cell)
    /// if the view is in the center of CollectionView it sends 0
    ///
    /// - Parameter progress: the interpolated progress for the cell view
    func transform(progress: CGFloat)
    
    /// Optional function for providing the Z index(position) of cell view
    /// As defined as an extension the default value of zIndex is Int(-abs(round(progress)))
    ///
    /// - Parameter progress: the interpolated progress for the cell view
    /// - Returns: the z index(position)
    func zPosition(progress: CGFloat) -> Int
}


extension TransformableView {
    
    func zPosition(progress: CGFloat) -> Int {
        Int(-abs(round(progress)))
    }
}
