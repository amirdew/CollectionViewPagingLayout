//
//  ViewAnimator.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 04/04/2021.
//

import QuartzCore

/// Simple protocol to define an animator
public protocol ViewAnimator {
    func animate(animations: @escaping (Double) -> Void)
}

/// Default implementation for `ViewAnimator`
public class DefaultViewAnimator: ViewAnimator {

    private let duration: TimeInterval
    private let curve: Curve

    private var displayLink: CADisplayLink?
    private var start: CFTimeInterval!
    private var animationsClosure: ((Double) -> Void)?

    public init(_ duration: TimeInterval, curve: Curve) {
        self.duration = duration
        self.curve = curve
    }

    public func animate(animations: @escaping (Double) -> Void) {
        #if targetEnvironment(simulator)
        let duration = Double(animationDragCoefficient()) * duration
        #endif
        guard duration > 0 else {
            animations(1.0)
            return
        }
        invalidateDisplayLink()
        start = CACurrentMediaTime()
        animationsClosure = animations
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
    }

    @objc private func update() {
        guard displayLink != nil else { return }
        let delta = CACurrentMediaTime() - start
        let progress = curve.fromLinear(progress: delta / duration)

        if progress == 1.0 {
            invalidateDisplayLink()
        }
        animationsClosure?(progress)
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
                if p < 0.5 { return 2 * p * p }
                result = (-2 * p * p) + (4 * p) - 1
            case .easeIn:
                result = -p * (p - 2)
            case .easeOut:
                result = p * p
            }
            return min(max(result, 0), 1)
        }

    }
}

#if targetEnvironment(simulator)
@_silgen_name("UIAnimationDragCoefficient") func UIAnimationDragCoefficient() -> Float

private func animationDragCoefficient() -> Float {
    return UIAnimationDragCoefficient()
}
#endif
