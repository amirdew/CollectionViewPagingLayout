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
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialStateForLayoutButtons()
    }
    
    
    // MARK: Event listeners
    
    @IBAction private func layoutCategoryButtonTouched(button: UIButton) {
        guard let view = button.superview else { return }
        
        setLayoutButtonSelected(view: stackButtonView, isSelected: view == stackButtonView)
        setLayoutButtonSelected(view: scaleButtonView, isSelected: view == scaleButtonView)
        setLayoutButtonSelected(view: snapshotButtonView, isSelected: view == snapshotButtonView)
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            view.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    // MARK: Private functions
    
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
    
    
}
