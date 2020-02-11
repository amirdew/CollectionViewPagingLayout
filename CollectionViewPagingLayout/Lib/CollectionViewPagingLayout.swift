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

    public var numberOfVisibleItems: Int?
    
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    
    weak var delegate: CollectionViewPagingLayoutDelegate?
    
    override public var collectionViewContentSize: CGSize {
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
    
    private(set) var currentPage: Int = 0
    
    private var visibleRect: CGRect {
        collectionView.map { CGRect(origin: $0.contentOffset, size: $0.bounds.size) } ?? .zero
    }
    
    private var numberOfItems: Int {
        collectionView?.numberOfItems(inSection: 0) ?? 0
    }

    // MARK: Public functions
    
    public func setCurrentPage(_ page: Int, animated: Bool = true) {
        var offset = (scrollDirection == .horizontal ? visibleRect.width : visibleRect.height) * CGFloat(page)
        offset = max(0, offset)
        offset = scrollDirection == .horizontal ? min(collectionViewContentSize.width - visibleRect.width, offset) : min(collectionViewContentSize.height - visibleRect.height, offset)
        let contentOffset = scrollDirection == .horizontal ? CGPoint(x: offset, y: 0) : CGPoint(x: 0, y: offset)
        collectionView?.setContentOffset(contentOffset, animated: animated)
    }
    
    public func goToNextPage(animated: Bool = true) {
        setCurrentPage(currentPage + 1, animated: animated)
    }
    
    public func goToPrevPage(animated: Bool = true) {
        setCurrentPage(currentPage - 1, animated: animated)
    }
    
    // MARK: UICollectionViewLayout
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let totalNumberOfItems = numberOfItems
        let attributesCount = numberOfVisibleItems ?? totalNumberOfItems
        
        let currentScrollOffset = self.currentScrollOffset
        let currentPageIndex = Int(round(currentScrollOffset))
        
        let visibleRangeMid = attributesCount / 2
        let startIndex = max(0, currentPageIndex - visibleRangeMid)
        let endIndex = min(totalNumberOfItems, currentPageIndex + visibleRangeMid)
        
        let visibleRect = self.visibleRect

        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
        for itemIndex in startIndex..<endIndex {
            let pageIndex = CGFloat(itemIndex)
            let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: itemIndex, section: 0))
            
            let progress = pageIndex - currentScrollOffset
            var zIndex = Int(-abs(round(progress)))

            if let numberOfVisibleItems = numberOfVisibleItems, abs(progress) >= CGFloat(numberOfVisibleItems) - 1 {
                cellAttributes.isHidden = true
            } else {
                let cell = collectionView?.cellForItem(at: cellAttributes.indexPath)
                // nil cell when not visible
                if cell == nil || cell is TransformableView {
                    cellAttributes.frame = visibleRect
                    (cell as? TransformableView)?.transform(progress: progress)
                    zIndex = (cell as? TransformableView)?.zPosition(progress: progress) ?? zIndex
                } else {
                    cellAttributes.frame = CGRect(
                        x: pageIndex * visibleRect.width,
                        y: 0,
                        width: visibleRect.size.width,
                        height: visibleRect.size.height
                    )
                }
            }
            cellAttributes.zIndex = zIndex
            layoutAttributes.append(cellAttributes)
        }

        return layoutAttributes
    }
    
    override public func invalidateLayout() {
        super.invalidateLayout()
        updateCurrentPageIfNeeded()
    }
    
    // MARK: Private
    
    private var currentScrollOffset: CGFloat {
        let visibleRect = self.visibleRect
        return scrollDirection == .horizontal ? (visibleRect.minX / max(visibleRect.width, 1)) : (visibleRect.minY / max(visibleRect.height, 1))
    }
    
    private func updateCurrentPageIfNeeded() {
        var currentPage: Int = 0
        if let collectionView = collectionView {
            let pageSize = scrollDirection == .horizontal ? collectionView.frame.width : collectionView.frame.height
            let contentOffset = scrollDirection == .horizontal ? (collectionView.contentOffset.x + collectionView.contentInset.left) : (collectionView.contentOffset.y + collectionView.contentInset.top)
            currentPage = Int(round(contentOffset / pageSize))
        }
        if currentPage != self.currentPage {
            self.currentPage = currentPage
            self.delegate?.onCurrentPageChanged(layout: self, currentPage: currentPage)
        }
    }
    
}
