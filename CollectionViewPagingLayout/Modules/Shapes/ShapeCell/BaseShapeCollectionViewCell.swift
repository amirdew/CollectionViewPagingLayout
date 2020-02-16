//
//  BaseShapeCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class BaseShapeCollectionViewCell: UICollectionViewCell, NibBased {
    
    // MARK: Properties
    
    var viewModel: ShapeCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet private weak var gradientView: GradientView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    
    // MARK: UICollectionViewCell
    
    override func awakeFromNib() {
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 36, weight: .light)
        gradientView.set(startPoint: .zero, endPoint: CGPoint(x: 1, y: 1))
        gradientView.layer.borderColor = UIColor.white.cgColor
        gradientView.layer.borderWidth = 5
        clipsToBounds = false
        contentView.clipsToBounds = false
    }
    
    private func updateViews() {
        titleLabel.text = viewModel?.title
        imageView.image = viewModel.let { UIImage(systemName: $0.iconName) }
        gradientView.set(colors: viewModel?.colors ?? [])
    }
    
}
