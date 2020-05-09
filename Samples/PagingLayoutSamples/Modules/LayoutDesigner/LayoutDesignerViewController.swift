//
//  LayoutDesignerViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 05/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class LayoutDesignerViewController: UIViewController, NibBased {
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBOutlet private weak var stackButtonView: UIView!
    @IBOutlet private weak var scaleButtonView: UIView!
    @IBOutlet private weak var snapshotButtonView: UIView!
    @IBOutlet private weak var previewContainerView: UIView!
    @IBOutlet private weak var codeContainerView: UIView!
    
    private var previewViewController: ShapesViewController!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    // MARK: Event listeners
    
    @IBAction private func layoutCategoryButtonTouched(button: UIButton) {
        guard let view = button.superview else { return }
        
        let layouts: [ShapeLayout]
        switch view {
        case stackButtonView:
            layouts = .stack
        case scaleButtonView:
            layouts = .scale
        case snapshotButtonView:
            layouts = .snapshot
        default:
            layouts = []
        }
        setLayoutsForPreview(layouts)
        
        setLayoutButtonSelected(view: stackButtonView, isSelected: view == stackButtonView)
        setLayoutButtonSelected(view: scaleButtonView, isSelected: view == scaleButtonView)
        setLayoutButtonSelected(view: snapshotButtonView, isSelected: view == snapshotButtonView)
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            view.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        setInitialStateForLayoutButtons()
        addPreviewController()
    }
    
    private func setInitialStateForLayoutButtons() {
        setLayoutButtonSelected(view: stackButtonView, isSelected: true)
        setLayoutButtonSelected(view: scaleButtonView, isSelected: false)
        setLayoutButtonSelected(view: snapshotButtonView, isSelected: false)
    }
    
    private func setLayoutButtonSelected(view: UIView, isSelected: Bool, animated: Bool = true) {
        guard let titleStackView = view.subviews.first(where: { $0 is UIStackView })?
            .subviews.first(where: { $0 is UIStackView }) else {
                return
        }
        titleStackView.isHidden = !isSelected
        
        let borderColor = UIColor.white.withAlphaComponent(0.66).cgColor
        let noBorderColor = UIColor.clear.cgColor
        
        let oldBorderColor = view.layer.borderColor
        view.layer.borderColor = isSelected ? borderColor : noBorderColor
        
        guard animated else {
            return
        }
        let borderAnimation = CABasicAnimation(keyPath: "borderColor")
        borderAnimation.duration = 0.4
        borderAnimation.fromValue = oldBorderColor
        borderAnimation.toValue = view.layer.borderColor
        view.layer.add(borderAnimation, forKey: nil)
    }
    
    private func addPreviewController() {
        previewViewController = ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: .stack, showBackButton: false))
        addChild(previewViewController)
        previewViewController.view.layer.cornerRadius = 30
        previewViewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        previewContainerView.fill(with: previewViewController.view)
        previewViewController.didMove(toParent: self)
    }
    
    private func setLayoutsForPreview(_ layouts: [ShapeLayout]) {
        previewViewController.viewModel = ShapesViewModel(layouts: layouts, showBackButton: false)
    }
    
}
