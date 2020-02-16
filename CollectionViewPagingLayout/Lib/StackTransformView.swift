//
//  StackTransformView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 14/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

protocol StackTransformView: TransformableView {}


extension StackTransformView where Self: UICollectionViewCell {
    
    func transform(progress: CGFloat) {
        let transform = CGAffineTransform(translationX: bounds.width/2 * progress, y: 0)
        let alpha = 1 - abs(progress)

        contentView.subviews.forEach { $0.transform = transform }
        contentView.alpha = alpha
    }
}
