//
//  BlurEffectView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 23/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
public class BlurEffectView: UIVisualEffectView {
    
    // MARK: Parameters
    
    private var animator: UIViewPropertyAnimator?
    private var radius: CGFloat?
    
    
    // MARK: Lifecycle
    
    deinit {
        animator?.stopAnimation(true)
    }
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        animator?.stopAnimation(true)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if animator?.state != .active {
            if let radius = radius, effect != nil {
                setBlurRadius(radius: radius)
            } else {
                removeFromSuperview()
            }
        }
    }
    
    
    // MARK: Public functions
    
    /// Create blur effect with custom radius
    ///
    /// - Parameters:
    ///   - effect: optional blur effect, eg UIBlurEffect(style: .dark), default value is current effect
    ///   - radius: blur intensity between 0.0 and 1.0
    public func setBlurRadius(effect: UIBlurEffect? = nil, radius: CGFloat = 1.0) {
        guard let effect = (effect ?? self.effect) as? UIBlurEffect else {
            return
        }
        if animator == nil ||
            self.effect == .none ||
            animator?.state != .active ||
            animator?.fractionComplete == 1 ||
            animator?.fractionComplete == 0 {
            
            animator?.stopAnimation(true)
            self.effect = nil
            animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in self.effect = effect }
        }
        self.radius = radius
        animator?.fractionComplete = radius
    }
    
}
