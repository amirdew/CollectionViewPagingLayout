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
    
    public override init() {
        currentPage = 0
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not available")
    }
    
    
    // MARK: Public functions
    
    public func setCurrentPage(_ page: Int, animated: Bool = true) {
        var offset = (scrollDirection == .horizontal ? visibleRect.width : visibleRect.height) * CGFloat(page)
        offset = max(0, offset)
        offset = scrollDirection == .horizontal ? min(collectionViewContentSize.width - visibleRect.width, offset) : min(collectionViewContentSize.height - visibleRect.height, offset)
        collectionView?.setContentOffset(scrollDirection == .horizontal ? .init(x: offset, y: 0) : .init(x: 0, y: offset),
                                         animated: animated)
    }
    
    public func goToNextPage(animated: Bool = true) {
        setCurrentPage(currentPage + 1, animated: animated)
    }
    
    public func goToPrevPage(animated: Bool = true) {
        setCurrentPage(currentPage - 1, animated: animated)
    }
    
    
    // MARK: UICollectionViewFlowLayout
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
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
            self.delegate?.onCurrentPageChanged(layout: self, currentPage: currentPage)
        }
    }
    
}
