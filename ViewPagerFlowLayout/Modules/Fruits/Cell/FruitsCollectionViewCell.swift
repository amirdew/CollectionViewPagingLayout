//
//  FruitsCollectionViewCell.swift
//  ViewPagerFlowLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit

class FruitsCollectionViewCell: UICollectionViewCell, NibBased {
    
    // MARK: Properties
    
    var viewModel: FruitCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    private var currentInterpolatedProgress: Double?
    
    @IBOutlet private weak var cardBackgroundView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var veganImageView: UIImageView!
    @IBOutlet private weak var veganLabelView: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceTypeLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var increaseQuantityButton: UIButton!
    @IBOutlet private weak var decreaseQuantityButton: UIButton!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        cardBackgroundView.layer.cornerRadius = 15
    }
    
    private func updateViews() {
        guard let viewModel = viewModel else {
            return
        }
        cardBackgroundView.backgroundColor = viewModel.cardBackgroundColor
        titleLabel.text = viewModel.fruit.title
        descriptionLabel.text = viewModel.fruit.description
        imageView.image = viewModel.image
    }
    
}


extension FruitsCollectionViewCell: TransformableView {
    
    func transform(progress: Double) {
        let floatProgress = CGFloat(progress)
        var translationX: CGFloat = 0
        
        translationX = 375 * floatProgress
        let scale = 1  - abs(0.3 * floatProgress)
        let angle = max(0 - abs(-CGFloat.pi/3 * floatProgress), -CGFloat.pi/3)
        imageView.transform = CGAffineTransform(translationX: translationX, y: floatProgress * imageView.frame.height/8)
        titleLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        descriptionLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        cardBackgroundView.transform =
            CGAffineTransform(translationX: translationX/1.55, y: 0)
                .scaledBy(x: scale, y: scale)
        
        var transform = CATransform3DIdentity;
        transform.m34 = -10 / 850.0;
        
        imageView.superview!.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 1)
        
        
    }
    
}
