//
//  ShapeCardView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 2/16/20.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class ShapeCardView: GradientView, NibBased {
    
    // MARK: Properties
    
    var viewModel: ShapeCardViewModel? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    
    // MARK: UICollectionViewCell
    
    override func awakeFromNib() {
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 36, weight: .light)
        set(startPoint: .zero, endPoint: CGPoint(x: 1, y: 1))
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
    }
    
    private func updateViews() {
        titleLabel.text = viewModel?.title
        imageView.image = viewModel.let { UIImage(systemName: $0.iconName) }
        viewModel.let { set(colors: $0.colors) }
    }
    
}
