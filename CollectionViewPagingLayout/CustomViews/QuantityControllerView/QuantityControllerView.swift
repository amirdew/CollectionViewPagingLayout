//
//  QuantityControllerView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/26/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit

protocol QuantityControllerViewDelegate: class {
    func onIncreaseButtonTouched(view: QuantityControllerView)
    func onDecreaseButtonTouched(view: QuantityControllerView)
}

class QuantityControllerView: UIView, NibBased {
    
    // MARK: Properties
    
    var quantity: Int = 0 { didSet { updateQuantity() } }
    weak var delegate: QuantityControllerViewDelegate?
    
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var increaseButton: UIButton!
    @IBOutlet private weak var decreaseButton: UIButton!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        quantityLabel.font = .systemFont(ofSize: 31, weight: .semibold)
        quantityLabel.textColor = UIColor.black.withAlphaComponent(0.69)
        updateQuantity()
    }
    
    
    // MARK: Listeners
    
    @IBAction private func onButtonTouched(sender: UIButton) {
        if sender == increaseButton {
            animateButtonTouch(isDecrease: false)
            delegate?.onIncreaseButtonTouched(view: self)
        }
        if sender == decreaseButton {
            animateButtonTouch(isDecrease: true)
            delegate?.onDecreaseButtonTouched(view: self)
        }
    }
    
    
    // MARK: Private functions
    
    private func updateQuantity() {
        quantityLabel.text = "\(quantity)"
    }
    
    private func animateButtonTouch(isDecrease: Bool, reset: Bool = false) {
        let timing = CAMediaTimingFunction(name: reset ? .easeIn : .easeOut)
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform")
        
        var newTransform = CATransform3DIdentity
        newTransform.m34 = -0.004;
        newTransform = CATransform3DRotate(newTransform, (isDecrease ? -1 : 1) * .pi/6, 0, 1, 0)
        
        CATransaction.begin()
        if !reset {
            CATransaction.setCompletionBlock { [weak self] in
                self?.animateButtonTouch(isDecrease: isDecrease, reset: true)
            }
        }
        CATransaction.setAnimationTimingFunction(timing)
        animation.duration = 0.18
        if reset {
            animation.fromValue = newTransform
            animation.toValue = CATransform3DIdentity
        } else {
            animation.fromValue = CATransform3DIdentity
            animation.toValue = newTransform
        }
        container.layer.transform = animation.toValue as! CATransform3D
        container.layer.add(animation, forKey: nil)
        CATransaction.commit()
    }
}

