//
//  ViewPagerFlowLayout.swift
//  ViewPagerFlowLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit

protocol TransformableView {
    
    /*
     Sends a float value based on the position of the cell
     if the cell is in the center of CollectionView it sends 0
     
     - Parameter progress: the interpolated progress for the cell view
     **/
    func transform(progress: CGFloat)
    
}


protocol ViewPagerFlowLayoutDelegate: class {
    func onCurrentPageChanged(layout: ViewPagerFlowLayout, currentPage: Int)
}


class ViewPagerFlowLayout: UICollectionViewLayout {
    
    // MARK: Properties
    
    var numberOfVisibleItems: Int?
    
    weak var delegate: ViewPagerFlowLayoutDelegate?
    
    private(set) var currentPage: Int
    
    private var visibleRect: CGRect {
        guard let collectionView = collectionView else {
            return .zero
        }
        return CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    }
    
    private var numberOfItems: Int {
        collectionView?.numberOfItems(inSection: 0) ?? 0
    }
    
    
    // MARK: Life cycle
    
    override init() {
        currentPage = 0
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not available")
    }
    
    
    // MARK: UICollectionViewFlowLayout
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: CGFloat(numberOfItems) * visibleRect.width, height: visibleRect.height)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray: [UICollectionViewLayoutAttributes] = []
        for row in 0..<numberOfItems {
            let attributes = UICollectionViewLayoutAttributes(forCellWith: .init(row: row, section: 0))
            let progress = CGFloat(row) - (visibleRect.minX / visibleRect.width)
            if let numberOfVisibleItems = numberOfVisibleItems, abs(progress) >= CGFloat(numberOfVisibleItems) - 1 {
                attributes.frame = .init(origin: .init(x: -2 * visibleRect.width, y: 0), size: visibleRect.size)
            } else {
                let cell = collectionView?.cellForItem(at: attributes.indexPath)
                if cell == nil || cell is TransformableView {
                    attributes.frame = visibleRect
                    (cell as? TransformableView)?.transform(progress: progress)
                } else {
                    attributes.frame = .init(origin: .init(x: CGFloat(row) * visibleRect.width, y: 0), size: visibleRect.size)
                }
            }
            attributes.zIndex = Int(-abs(round(progress)))
            attributesArray.append(attributes)
        }
        return attributesArray
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        updateCurrentPageIfNeeded()
    }
    
    
    // MARK: Private functions
    
    private func updateCurrentPageIfNeeded() {
        var currentPage: Int = 0
        if let collectionView = collectionView {
            let pageWidth = collectionView.frame.width
            let contentOffset = collectionView.contentOffset.x + collectionView.contentInset.left
            currentPage = Int(round(contentOffset / pageWidth))
        }
        if currentPage != self.currentPage {
            self.currentPage = currentPage
            self.delegate?.onCurrentPageChanged(layout: self, currentPage: currentPage)
        }
    }
    
}
