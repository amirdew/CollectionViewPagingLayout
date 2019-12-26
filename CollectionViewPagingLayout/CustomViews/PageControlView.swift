//
//  PageControlView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/24/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit

class PageControlView: UIView {
    
    // MARK: Properties
    
    var preferences = Preferences() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var numberOfPages: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    // MARK: Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard numberOfPages > 0 else {
                return
        }
        drawDots(rect: rect)
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: CGFloat(numberOfPages) * (preferences.dotRadius * 2) + (CGFloat(numberOfPages) - 1) * preferences.gapSize + preferences.currentDotBorderWidth * 2,
            height: preferences.dotRadius * 2 + preferences.currentDotBorderWidth * 2
        )
    }
    
    
    // MARK: Private functions
    
    private func commonInit() {
        backgroundColor = .clear
    }
    
    private func drawDots(rect: CGRect) {
        for index in 0..<numberOfPages {
            let path = UIBezierPath(
                arcCenter: .init(
                    x: preferences.dotRadius + preferences.currentDotBorderWidth + CGFloat(index) * (preferences.gapSize + preferences.dotRadius * 2),
                    y: rect.height / 2
                ),
                radius: preferences.dotRadius,
                startAngle: 0,
                endAngle: .pi * 2,
                clockwise: true)
            if index == currentPage {
                path.lineWidth = preferences.currentDotBorderWidth
                preferences.color.set()
                path.stroke()
            } else {
                preferences.color.withAlphaComponent(preferences.dimFactor).set()
                path.fill()
            }
        }
    }
}


extension PageControlView {
    
    struct Preferences {
        
        // MARK: Properties
        
        var color: UIColor = .white
        var dimFactor: CGFloat = 0.57
        var dotRadius: CGFloat = 3.5
        var gapSize: CGFloat = 5
        var currentDotBorderWidth: CGFloat = 3
    }
}
