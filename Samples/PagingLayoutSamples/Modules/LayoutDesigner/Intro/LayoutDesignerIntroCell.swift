//
//  LayoutDesignerIntroCell.swift
//  PagingLayoutSamples
//
//  Created by Amir on 09/07/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

protocol LayoutDesignerIntroCellDelegate: AnyObject {
    func layoutDesignerIntroCell(_ cell: LayoutDesignerIntroCell, onLeftButtonTouched button: UIButton)
    func layoutDesignerIntroCell(_ cell: LayoutDesignerIntroCell, onRightButtonTouched button: UIButton)
}


class LayoutDesignerIntroCell: UICollectionViewCell, NibBased {
    
    // MARK: Properties

    var introInfo: LayoutDesignerIntroInfo? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: LayoutDesignerIntroCellDelegate?
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    
    // MARK: Listeners
    
    @IBAction private func onLeftButtonTouched() {
        delegate?.layoutDesignerIntroCell(self, onLeftButtonTouched: leftButton)
    }
    
    @IBAction private func onRightButtonTouched() {
        delegate?.layoutDesignerIntroCell(self, onRightButtonTouched: rightButton)
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        
    }
    
    private func updateViews() {
        guard let info = introInfo else { return }
        titleLabel.text = info.title
        if let headerImageName = info.headerImageName {
            headerImageView.isHidden = false
            headerImageView.image = UIImage(named: headerImageName)
        } else {
            headerImageView.isHidden = true
        }
        if let imageName = info.imageName {
            imageView.isHidden = false
            imageView.image = UIImage(named: imageName)
        } else {
            imageView.isHidden = true
        }
        descriptionLabel.text = info.description
        
        leftButton.setTitle(info.leftButtonTitle, for: .normal)
        rightButton.setTitle(info.rightButtonTitle, for: .normal)
    }
    
}


extension LayoutDesignerIntroCell: ScaleTransformView {
    
    var scaleOptions: ScaleTransformViewOptions {
       ScaleTransformViewOptions(
           minScale: 0.00,
           maxScale: 1.35,
           scaleRatio: 0.39,
           translationRatio: .init(x: 0.10, y: 0.10),
           minTranslationRatio: .init(x: -1.00, y: 0.00),
           maxTranslationRatio: .init(x: 1.00, y: 1.00),
           keepVerticalSpacingEqual: true,
           keepHorizontalSpacingEqual: true,
           scaleCurve: .linear,
           translationCurve: .linear,
           shadowEnabled: false,
           rotation3d: .init(
               angle: 0.60,
               minAngle: -1.05,
               maxAngle: 1.05,
               x: 0.00,
               y: 0.00,
               z: 1.00,
               m34: 0
           ),
           translation3d: .init(
               translateRatios: (0.90, 0.10, 0.00),
               minTranslateRatios: (-3.00, -0.80, -0.30),
               maxTranslateRatios: (3.00, 0.80, -0.30)
           )
       )
    }
    
    var scalableView: UIView {
        stackView
    }
}
