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
    
    weak var delegate: CollectionViewPagingLayoutDelegate?
    
    override public var collectionViewContentSize: CGSize {
        let safeAreaLeftRight = (collectionView?.safeAreaInsets.left ?? 0) + (collectionView?.safeAreaInsets.right ?? 0)
        let safeAreaTopBottom = (collectionView?.safeAreaInsets.top ?? 0) + (collectionView?.safeAreaInsets.bottom ?? 0)
        return CGSize(width: CGFloat(numberOfItems) * visibleRect.width - safeAreaLeftRight, height: visibleRect.height - safeAreaTopBottom)
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
        var offset = visibleRect.width * CGFloat(page)
        offset = max(0, offset)
        offset = min(collectionViewContentSize.width - visibleRect.width, offset)
        collectionView?.setContentOffset(.init(x: offset, y: 0), animated: animated)
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
        for row in 0..<numberOfItems {
            let attributes = UICollectionViewLayoutAttributes(forCellWith: .init(row: row, section: 0))
            let progress = CGFloat(row) - (visibleRect.minX / visibleRect.width)
            if let numberOfVisibleItems = numberOfVisibleItems, abs(progress) >= CGFloat(numberOfVisibleItems) - 1 {
                attributes.isHidden = true
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
    
    override public func invalidateLayout() {
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
