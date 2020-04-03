//
//  LayoutTypeCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class LayoutTypeCollectionViewCell: UICollectionViewCell, NibBased {
    
    // MARK: Properties
    
    var viewModel: LayoutTypeCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet private weak var circleView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    
    // MARK: UICollectionViewCell
    
    override func awakeFromNib() {
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        titleLabel.textColor = .gray
        subtitleLabel.font = .systemFont(ofSize: 18, weight: .ultraLight)
        subtitleLabel.textColor = .gray
        imageView.tintColor = .gray
        clipsToBounds = false
        contentView.clipsToBounds = false
        circleView.layer.cornerRadius = 50
    }
    
    private func updateViews() {
        titleLabel.text = viewModel?.title
        subtitleLabel.text = viewModel?.subtitle
        imageView.image = (viewModel?.iconName).let { UIImage(systemName: $0) }
    }
    
}


extension LayoutTypeCollectionViewCell: ScaleTransformView {
    
    var scalableView: UIView {
        circleView
    }
    
    func transform(progress: CGFloat) {
        applyScaleTransform(progress: progress)
        titleLabel.alpha = 1 - abs(progress)
        subtitleLabel.alpha = titleLabel.alpha
    }

}
