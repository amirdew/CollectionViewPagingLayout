//
//  CollectionViewPagingLayout.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit

public protocol CollectionViewPagingLayoutDelegate: class {
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int)
}


public class CollectionViewPagingLayout: UICollectionViewLayout {
    
    // MARK: Properties
    
    public var numberOfVisibleItems: Int?
    
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    
    public weak var delegate: CollectionViewPagingLayoutDelegate?
    
    override public var collectionViewContentSize: CGSize {
        getContentSize()
    }
    
    private(set) var currentPage: Int = 0 {
        didSet {
            delegate?.onCurrentPageChanged(layout: self, currentPage: currentPage)
        }
    }
    
    private var visibleRect: CGRect {
        guard let collectionView = collectionView else {
            return .zero
        }
        return CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    }
    
    private var numberOfItems: Int {
        collectionView?.numberOfItems(inSection: 0) ?? 0
    }
    
    
    // MARK: Public functions
    
    public func setCurrentPage(_ page: Int, animated: Bool = true) {
        safelySetCurrentPage(page, animated: animated)
    }
    
    public func goToNextPage(animated: Bool = true) {
        setCurrentPage(currentPage + 1, animated: animated)
    }
    
    public func goToPreviousPage(animated: Bool = true) {
        setCurrentPage(currentPage - 1, animated: animated)
    }
    
    
    // MARK: UICollectionViewFlowLayout
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray: [UICollectionViewLayoutAttributes] = []
        var numberOfAttributes = min(numberOfItems, numberOfVisibleItems ?? numberOfItems)
        numberOfAttributes = max(numberOfAttributes, 3)
        if numberOfAttributes % 2 == 0 {
            numberOfAttributes += 1
        }
        
        let currentIndex = Int(round(scrollDirection == .horizontal ? (visibleRect.minX / visibleRect.width) : (visibleRect.minY / visibleRect.height)))
        let startIndex = max(0, currentIndex - (numberOfAttributes - 1)/2)
        numberOfAttributes = min(numberOfItems - startIndex, numberOfAttributes)
        
        for index in startIndex..<startIndex + numberOfAttributes {
            let attributes = UICollectionViewLayoutAttributes(forCellWith: .init(row: index, section: 0))
            let progress = CGFloat(index) - (scrollDirection == .horizontal ? (visibleRect.minX / visibleRect.width) : (visibleRect.minY / visibleRect.height))
            var zIndex = Int(-abs(round(progress)))
            if let numberOfVisibleItems = numberOfVisibleItems, abs(progress) >= CGFloat(numberOfVisibleItems) - 1 {
                attributes.isHidden = true
            } else {
                let cell = collectionView?.cellForItem(at: attributes.indexPath)
                if cell == nil || cell is TransformableView {
                    attributes.frame = visibleRect
                    (cell as? TransformableView)?.transform(progress: progress)
                    zIndex = (cell as? TransformableView)?.zPosition(progress: progress) ?? zIndex
                } else {
                    attributes.frame = .init(origin: .init(x: CGFloat(index) * visibleRect.width, y: 0), size: visibleRect.size)
                }
            }
            attributes.zIndex = zIndex
            attributesArray.append(attributes)
        }
        return attributesArray
    }
    
    override public func invalidateLayout() {
        super.invalidateLayout()
        updateCurrentPageIfNeeded()
    }
    
    
    // MARK: Private functions
    
    private func updateCurrentPageIfNeeded() {
        var currentPage: Int = 0
        if let collectionView = collectionView {
            let pageSize = scrollDirection == .horizontal ? collectionView.frame.width : collectionView.frame.height
            let contentOffset = scrollDirection == .horizontal ? (collectionView.contentOffset.x + collectionView.contentInset.left) : (collectionView.contentOffset.y + collectionView.contentInset.top)
            currentPage = Int(round(contentOffset / pageSize))
        }
        if currentPage != self.currentPage {
            self.currentPage = currentPage
        }
    }
    
    private func getContentSize() -> CGSize {
        var safeAreaLeftRight: CGFloat = 0
        var safeAreaTopBottom: CGFloat = 0
        if #available(iOS 11, *) {
            safeAreaLeftRight = (collectionView?.safeAreaInsets.left ?? 0) + (collectionView?.safeAreaInsets.right ?? 0)
            safeAreaTopBottom = (collectionView?.safeAreaInsets.top ?? 0) + (collectionView?.safeAreaInsets.bottom ?? 0)
        }
        if scrollDirection == .horizontal {
            return CGSize(width: CGFloat(numberOfItems) * visibleRect.width, height: visibleRect.height - safeAreaTopBottom)
        } else {
             return CGSize(width: visibleRect.width - safeAreaLeftRight, height: CGFloat(numberOfItems) * visibleRect.height)
        }
    }
    
    private func safelySetCurrentPage(_ page: Int, animated: Bool) {
        let pageSize = scrollDirection == .horizontal ? visibleRect.width : visibleRect.height
        let contentSize = scrollDirection == .horizontal ? collectionViewContentSize.width : collectionViewContentSize.height
        let maxPossibleOffset = contentSize - pageSize
        var offset = pageSize * CGFloat(page)
        offset = max(0, offset)
        offset = min(offset, maxPossibleOffset)
        let contentOffset: CGPoint = scrollDirection == .horizontal ? .init(x: offset, y: 0) : .init(x: 0, y: offset)
        collectionView?.setContentOffset(contentOffset, animated: animated)
    }
}
