//
//  FruitsCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class FruitsCollectionViewCell: UICollectionViewCell, NibBased {
    
    // MARK: Properties
    
    var viewModel: FruitCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    private let priceTagView = PriceTagView.instantiate()
    private let quantityControllerView = QuantityControllerView.instantiate()
    
    @IBOutlet private weak var pageTitleLabel: UILabel!
    @IBOutlet private weak var cardViewContainer: UIView!
    @IBOutlet private weak var cardBackgroundView: UIView!
    @IBOutlet private weak var pageControlView: PageControlView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var veganContainerView: UIView!
    @IBOutlet private weak var priceTagViewContainer: UIView!
    @IBOutlet private weak var quantityControllerContainer: UIView!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        cardBackgroundView.layer.cornerRadius = 15
        cardBackgroundView.layer.shadowOffset = .init(width: 0, height: 0.5)
        cardBackgroundView.layer.shadowOpacity = 0.7
        cardBackgroundView.layer.shadowRadius = 7
        clipsToBounds = false
        contentView.clipsToBounds = false
        pageTitleLabel.font = .systemFont(ofSize: 27, weight: .bold)
        titleLabel.font = .systemFont(ofSize: 27, weight: .bold)
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .gray
        priceTagViewContainer.fill(with: priceTagView)
        quantityControllerContainer.fill(with: quantityControllerView)
    }
    
    private func updateViews() {
        guard let viewModel = viewModel else {
            return
        }
        cardBackgroundView.backgroundColor = viewModel.cardBackgroundColor
        cardBackgroundView.layer.shadowColor = viewModel.cardBackgroundColor.cgColor
        titleLabel.text = viewModel.fruit.title
        descriptionLabel.text = viewModel.fruit.description
        imageView.image = viewModel.image
        pageControlView.numberOfPages = viewModel.numberOfItems
        pageControlView.currentPage = viewModel.index
        pageTitleLabel.text = viewModel.fruit.pageTitle
        veganContainerView.isHidden = !viewModel.fruit.isVegan
        priceTagView.price = viewModel.fruit.price
        priceTagView.priceType = viewModel.fruit.priceType
        quantityControllerView.delegate = self
        quantityControllerView.quantity = viewModel.quantity
    }
    
}


extension FruitsCollectionViewCell: TransformableView {
    
    func transform(progress: CGFloat) {
        transformPageTitle(progress: progress)
        transformCardView(progress: progress)
        transformPriceTagView(progress: progress)
        
        let normalTransform = CGAffineTransform(translationX: bounds.width * progress, y: 0)
        veganContainerView.transform = normalTransform
        titleLabel.transform = normalTransform
        descriptionLabel.transform = normalTransform
        pageControlView.transform = normalTransform
        
        pageControlView.alpha = 1 - abs(progress) / 0.5
        quantityControllerContainer.isHidden = !(-0.5 < progress && progress < 0.5)
    }
    
    
    // MARK: Private functions
    
    private func transformPriceTagView(progress: CGFloat) {
        let angle = .pi * progress
        var transform = CATransform3DIdentity
        transform.m34 = -0.008
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        priceTagViewContainer.layer.transform = transform
        priceTagViewContainer.alpha = abs(progress) > 0.5 ? 0 : 1
    }
    
    private func transformPageTitle(progress: CGFloat) {
        let pageTitleWidth: CGFloat = 80
        let pageTitleScale = max(1 - abs(0.3 * progress), 0.7)
        let pageTitleX = pageTitleWidth / 2 + progress * pageTitleWidth - (pageTitleScale * pageTitleWidth) / 2
        pageTitleLabel.transform = CGAffineTransform(translationX: pageTitleX, y: 0)
            .scaledBy(x: pageTitleScale, y: pageTitleScale)
        var pageTitleAlpha = max(1 - abs(0.7 * progress), 0.3)
        if progress < 0 {
            pageTitleAlpha = max(1 + progress, 0)
        }
        pageTitleLabel.alpha = pageTitleAlpha
    }
    
    private func transformCardView(progress: CGFloat) {
        let translationX: CGFloat = bounds.width * progress
        
        let imageScale = 1 - abs(0.5 * progress)
        imageView.transform = CGAffineTransform(translationX: translationX, y: progress * imageView.frame.height / 8)
            .scaledBy(x: imageScale, y: imageScale)
        
        let cardBackgroundScale = 1 - abs(0.3 * progress)
        cardBackgroundView.transform = CGAffineTransform(translationX: translationX / 1.55, y: 0)
            .scaledBy(x: cardBackgroundScale, y: cardBackgroundScale)
        
        var transform = CATransform3DIdentity
        if progress < 0 {
            let angle = max(0 - abs(-CGFloat.pi / 3 * progress), -CGFloat.pi / 3)
            transform.m34 = -0.011
            transform = CATransform3DRotate(transform, angle, 0, 1, 1)
        } else {
            let angle = max(0 - abs(-CGFloat.pi / 8 * progress), -CGFloat.pi / 8)
            transform.m34 = 0.002
            transform.m41 = bounds.width * 0.093 * progress
            transform = CATransform3DRotate(transform, angle, 0, 1, -0.1)
        }
        cardViewContainer.layer.transform = transform
    }
    
}


extension FruitsCollectionViewCell: QuantityControllerViewDelegate {
    
    // Note:
    // this is an example, in an ideal world we want to save the new quantity properly
    
    func onDecreaseButtonTouched(view: QuantityControllerView) {
        let current = viewModel?.quantity ?? 0
        viewModel?.quantity = max(0, current - 1)
    }
    func onIncreaseButtonTouched(view: QuantityControllerView) {
        let current = viewModel?.quantity ?? 0
        viewModel?.quantity = current + 1
    }
}
