//
//  PhotoCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/27/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell, NibBased {
    
    // MARK: Properties
    
    var viewModel: PhotoCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    private var zoomAnimator: UIViewPropertyAnimator?
    private var textAnimator: UIViewPropertyAnimator?
    private var zooming: Bool = false
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var photoContainerView: UIView!
    @IBOutlet private weak var photoImageFrameView: UIView!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var backgroundContainerView: UIView!
    @IBOutlet private weak var backgroundVisualEffectView: UIVisualEffectView!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        setupViews()
    }
    
    deinit {
        zoomAnimator?.stopAnimation(true)
        textAnimator?.stopAnimation(true)
    }
    
    // MARK: Private functions
    
    private func setupViews() {
        clipsToBounds = false
        contentView.clipsToBounds = false
        photoImageFrameView.layer.cornerRadius = 6
        photoImageFrameView.clipsToBounds = true
        backgroundColor = .clear
        
        photoContainerView.layer.cornerRadius = photoImageFrameView.layer.cornerRadius
        photoContainerView.layer.shadowColor = UIColor.black.cgColor
        photoContainerView.layer.shadowOpacity = 0.5
        photoContainerView.layer.shadowOffset = .init(width: 0, height: 2)
        photoContainerView.layer.shadowRadius = 23
        
        titleLabel.font = .systemFont(ofSize: 33, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOpacity = 0.5
        titleLabel.layer.shadowOffset = .init(width: 0, height: 2)
        titleLabel.layer.shadowRadius = 2
        
        subtitleLabel.font = .systemFont(ofSize: 26, weight: .light)
        subtitleLabel.textColor = .white
        subtitleLabel.alpha = 0.74
        subtitleLabel.layer.shadowColor = UIColor.black.cgColor
        subtitleLabel.layer.shadowOpacity = 0.5
        subtitleLabel.layer.shadowOffset = .init(width: 0, height: 2)
        subtitleLabel.layer.shadowRadius = 2
        
        photoContainerView.layer.zPosition = 500
        titleLabel.layer.zPosition = 1000
        subtitleLabel.layer.zPosition = 1000
        backgroundVisualEffectView.effect = UIBlurEffect(style: .dark)
    }
    
    private func updateViews() {
        guard let viewModel = viewModel else {
            return
        }
        photoImageView.image = UIImage(named: viewModel.imageName)
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        backgroundImageView.image = photoImageView.image
    }
    
    private func setupAndStartScaleAnimation() {
        guard zoomAnimator == nil else {
            zoomAnimator?.startAnimation()
            return
        }
        zooming = !zooming
        zoomAnimator = UIViewPropertyAnimator(duration: 7, curve: .linear) { [weak self] in
            guard let self = self else { return }
            let scale: CGFloat = self.zooming ? 1.2 : 1
            let transform = CATransform3DGetAffineTransform(CATransform3DScale(CATransform3DIdentity, scale, scale, scale))
            self.photoImageView.transform = transform
        }
        zoomAnimator?.addCompletion({ [weak self] _ in
            self?.zoomAnimator = nil
            self?.setupAndStartScaleAnimation()
        })
        zoomAnimator?.startAnimation()
    }
    
    private func setupAndStartTextAnimation() {
        guard textAnimator == nil else {
            textAnimator?.startAnimation()
            return
        }
        textAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) { [weak self] in
            guard let self = self else { return }
            self.titleLabel.transform = CATransform3DGetAffineTransform(CATransform3DIdentity)
            self.subtitleLabel.transform = CATransform3DGetAffineTransform(CATransform3DIdentity)
        }
        textAnimator?.addCompletion({ [weak self] _ in
            self?.textAnimator = nil
        })
        textAnimator?.startAnimation()
    }
    
}


extension PhotoCollectionViewCell: TransformableView {
    
    func transform(progress: CGFloat) {
        transformPhotoView(progress: progress)
        transformTexts(progress: progress)
        
        backgroundContainerView.alpha = 1 - abs(progress)
    }
    
    
    // MARK: Private functions
    
    private func transformTexts(progress: CGFloat) {
        if progress == 0 {
            setupAndStartTextAnimation()
        } else {
            textAnimator?.fractionComplete = 1
            let transform1 = CGAffineTransform(translationX: 0, y: 10 + 200 * abs(progress) / 2)
                .scaledBy(x: 1, y: 1.2 + 2 * abs(progress))
            let transform2 = CGAffineTransform(translationX: 0, y: 20 + 190 * abs(progress) / 2)
                .scaledBy(x: 1, y: 1.2 + 1.5 * abs(progress))
            titleLabel.transform = transform1
            subtitleLabel.transform = transform2
            titleLabel.alpha = 1 - abs(progress) / 0.3
            subtitleLabel.alpha = titleLabel.alpha
        }
    }
    
    private func transformPhotoView(progress: CGFloat) {
        if progress == 0 {
            setupAndStartScaleAnimation()
        } else {
            zoomAnimator?.pauseAnimation()
        }
        let angle = .pi * progress
        var transform = CATransform3DIdentity;
        transform.m34 = -0.0015;
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        photoContainerView.layer.transform = transform
        photoContainerView.alpha = abs(progress) > 0.5 ? 0 : 1
    }
    
}
