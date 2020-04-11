//
//  CardCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 01/11/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit
import CollectionViewPagingLayout

class CardCollectionViewCell: UICollectionViewCell, NibBased {
    
    // MARK: Properties
    
    var viewModel: CardCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var backgroundContainerView: UIView!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        clipsToBounds = false
        contentView.clipsToBounds = false
        backgroundColor = .clear
        
        backgroundContainerView.backgroundColor = .clear
        backgroundContainerView.layer.cornerRadius = 20
        imageView.layer.cornerRadius = 20
        backgroundContainerView.layer.shadowColor = UIColor.black.cgColor
        backgroundContainerView.layer.shadowOpacity = 0.6
        backgroundContainerView.layer.shadowOffset = .init(width: 0, height: 2)
        backgroundContainerView.layer.shadowRadius = 10
    }
    
    private func updateViews() {
        guard let viewModel = viewModel else {
            return
        }
        imageView.image = UIImage(named: viewModel.imageName)
    }

}


extension CardCollectionViewCell: TransformableView {
    
    func transform(progress: CGFloat) {
        var alpha = 1 + progress
        var y = progress * 13
        var angle: CGFloat = 0
        var scale: CGFloat = 1 - progress * 0.05
        
        if progress > 3 {
            alpha = 1 - progress + 3
            y = 3 * 13
        }
        
        let offset: CGFloat = 240
        
        if progress < 0, progress >= -0.5 {
            alpha = 1
            let lProgress = -logProgress(min: 0, max: -0.5, progress: progress)
            y = lProgress * offset
            angle = lProgress * (-.pi * 0.08)
        } else if progress < -0.5, progress > -1 {
            alpha = 1
            let lProgress = logProgress(min: -0.5, max: -1.0, progress: progress, reverse: true)
            y = -offset + lProgress * (CGFloat(offset + 30))
            angle = CGFloat(.pi * 0.08) - lProgress * CGFloat(.pi * 0.08)
        }
        
        if progress < -0.5 {
            scale = 1 + 0.5 * 0.05 + ((progress + 0.5) * 0.35)
        }

        let adjustScaleProgress = abs(round(progress) - progress)
        let adjustScaleLogProgress = logProgress(min: 0, max: 0.5, progress: adjustScaleProgress)
        var adjustScale = adjustScaleLogProgress * 0.1
        if progress < 0, progress >= -1.0 {
            adjustScale *= -1
        }
        
        scale -= adjustScale
        
        backgroundContainerView.alpha = alpha
        backgroundContainerView.transform = CGAffineTransform(translationX: 0, y: y).scaledBy(x: scale, y: scale).rotated(by: angle)
            
    }
    
    func zPosition(progress: CGFloat) -> Int {
        if progress < -0.5 {
            return -10
        }
        return Int(-abs(round(progress)))
    }
    
    
    // MARK: Private functions
    
    private func logProgress(min: CGFloat, max: CGFloat, progress: CGFloat, reverse: Bool = false) -> CGFloat {
        let logValue = (abs(progress - min) / abs(max - min)) * 99
        let value: CGFloat
        if reverse {
            value = 1 - log10(1 + (99 - logValue)) / 2
        } else {
            value = log10(1 + logValue) / 2
        }
        return value
    }
    
}
