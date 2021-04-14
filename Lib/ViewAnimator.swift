//
//  ViewAnimator.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 04/04/2021
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import QuartzCore

/// Simple protocol to define an animator
public protocol ViewAnimator {
    /// Animate
    /// - Parameter animations: Closure to animate
    /// - parameter progress: the animation progress, between 0.0 - 1.0
    /// - parameter finished: animation finished state, set to true at the end
    @discardableResult func animate(animations: @escaping (_ progress: Double, _ finished: Bool) -> Void) -> ViewAnimatorCancelable?
}


public protocol ViewAnimatorCancelable {

    /// Cancel the animation with changing progress
    func cancel()
}


/// Default implementation for `ViewAnimator`
public class DefaultViewAnimator: ViewAnimator {

    private let animationDuration: TimeInterval
    private let curve: Curve

    private var displayLink: CADisplayLink?
    private var start: CFTimeInterval!
    private var animationsClosure: ((Double, Bool) -> Void)?

    private var duration: TimeInterval {
        #if targetEnvironment(simulator)
        return Double(animationDragCoefficient()) * animationDuration
        #else
        return animationDuration
        #endif
    }

    public init(_ duration: TimeInterval, curve: Curve) {
        self.animationDuration = duration
        self.curve = curve
    }

    public func animate(animations: @escaping (Double, Bool) -> Void) -> ViewAnimatorCancelable? {
        if !Thread.isMainThread {
            fatalError("only from main thread")
        }
        guard duration > 0 else {
            animations(1.0, true)
            return nil
        }
        invalidateDisplayLink()
        start = CACurrentMediaTime()
        animationsClosure = animations
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: .common)
        self.displayLink = displayLink
        return Cancelable { [weak self] in
            self?.invalidateDisplayLink()
        }
    }

    @objc private func update() {
        guard displayLink != nil else { return }
        let delta = CACurrentMediaTime() - start
        let progress = curve.fromLinear(progress: delta / duration)

        animationsClosure?(progress, false)
        if delta / duration > 1 {
            animationsClosure?(progress, true)
            invalidateDisplayLink()
        }
    }

    private func invalidateDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
}

public extension DefaultViewAnimator {
    enum Curve {
        case linear, parametric, easeInOut, easeIn, easeOut

        func fromLinear(progress: Double) -> Double {
            let p = min(max(progress, 0), 1)
            let result: Double
            switch self {
            case .linear:
                result = p
            case .parametric:
                result = ((p * p) / (2.0 * ((p * p) - p) + 1.0))
            case .easeInOut:
                if p < 0.5 {
                    result = 2 * p * p
                } else {
                    result = (-2 * p * p) + (4 * p) - 1
                }
            case .easeIn:
                result = -p * (p - 2)
            case .easeOut:
                result = p * p
            }
            return min(max(result, 0), 1)
        }

    }
}

extension DefaultViewAnimator {
    private struct Cancelable: ViewAnimatorCancelable {
        var onCancel: () -> Void

        func cancel() {
            onCancel()
        }
    }
}

#if targetEnvironment(simulator)
@_silgen_name("UIAnimationDragCoefficient") func UIAnimationDragCoefficient() -> Float

private func animationDragCoefficient() -> Float {
    UIAnimationDragCoefficient()
}
#endif
