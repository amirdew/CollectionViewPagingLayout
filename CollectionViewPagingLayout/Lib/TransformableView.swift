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
    
    /*
     Sends a float value based on the position of the view (cell)
     if the view is in the center of CollectionView it sends 0
     
     - Parameter progress: the interpolated progress for the cell view
     **/
    func transform(progress: CGFloat)
    
}
