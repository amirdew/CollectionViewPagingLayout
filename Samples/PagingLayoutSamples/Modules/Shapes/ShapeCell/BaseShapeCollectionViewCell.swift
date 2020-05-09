//
//  BaseShapeCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class BaseShapeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var viewModel: ShapeCardViewModel? {
        didSet {
            updateViews()
        }
    }
    
    private(set) var shapeCardView: ShapeCardView!
    private var edgeConstraints: [NSLayoutConstraint]?
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let edgeConstraints = edgeConstraints else {
            return
        }
        let leftRightMargin = frame.width * 0.18
        let topBottomMargin = frame.height * 0.06
        edgeConstraints[0].constant = leftRightMargin
        edgeConstraints[2].constant = -leftRightMargin
        
        edgeConstraints[1].constant = topBottomMargin
        edgeConstraints[3].constant = -topBottomMargin
    }
    
    // MARK: Private functions
    
    private func setupViews() {
        shapeCardView = ShapeCardView.instantiate()
        let leftRightMargin = frame.width * 0.18
        let topBottomMargin = frame.height * 0.06
        edgeConstraints = contentView.fill(
            with: shapeCardView,
            edges: UIEdgeInsets(top: topBottomMargin, left: leftRightMargin, bottom: -topBottomMargin, right: -leftRightMargin)
        )
        clipsToBounds = false
        contentView.clipsToBounds = false
    }
    
    private func updateViews() {
        shapeCardView.viewModel = viewModel
    }
    
}
