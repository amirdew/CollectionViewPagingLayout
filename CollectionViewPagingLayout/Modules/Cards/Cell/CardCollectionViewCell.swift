//
//  CardCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 01/11/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

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
            y = progress * (offset / 0.5)
            angle = progress * ((-.pi * 0.08) / 0.5)
        } else if progress < -0.5, progress >= -1 {
            alpha = 1
            y = -offset - (progress + 0.5) * (CGFloat(offset + 30) / 0.5)
            angle = CGFloat(.pi * 0.08) - CGFloat((progress + 0.5) * CGFloat((-.pi * 0.08) / 0.5))
        }
        
        if progress < -0.5 {
            scale = 1 + 0.5 * 0.05 + ((progress + 0.5)  * 0.35)
        }
        
        var adjustScale = (abs(round(progress) - progress)) * 0.2
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
    
}
