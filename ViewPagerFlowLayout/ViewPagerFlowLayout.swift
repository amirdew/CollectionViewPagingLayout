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
     Sends a double value based on the position of the cell
     if the cell is in the center of CollectionView it sends 0
     
     - Parameter progress: the interpolated progress for the cell view
     **/
    func transform(progress: Double)
    
}


protocol ViewPagerFlowLayoutDelegate: class {
    func onCurrentPageChanged(layout: ViewPagerFlowLayout, currentPage: Int)
}


class ViewPagerFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: Properties
    
    weak var delegate: ViewPagerFlowLayoutDelegate?
    
    private(set) var currentPage: Int
    
    private var collectionViewSize: CGSize?
    
    private var visibleRect: CGRect {
        guard let collectionView = collectionView else {
            return .zero
        }
        return CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    }
    
    
    // MARK: Life cycle
    
    override init() {
        currentPage = 0
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not available")
    }
    
    
    // MARK: UICollectionViewFlowLayout
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard var attributesArray = super.layoutAttributesForElements(in: rect) else {
                return super.layoutAttributesForElements(in: rect)
        }
        attributesArray = attributesArray.compactMap { $0.copy() as? UICollectionViewLayoutAttributes }
        
        for attributes in attributesArray {
            let distanceFromCenter = visibleRect.midX - attributes.center.x
            let absDistanceFromCenter = abs(distanceFromCenter)
            attributes.transform = CGAffineTransform(translationX: distanceFromCenter, y: 0)
            let alpha = 1 - absDistanceFromCenter/(visibleRect.width * 2)
            //attributes.alpha = alpha
        }
        
        updateCurrentPageIfNeeded()
        updateTransformableCells()
        
        return attributesArray
    }
    
    
    // MARK: Private functions
    
    private func getInterpolatedProgressForItem(indexPath: IndexPath) -> Double {
        guard let attributes = self.layoutAttributesForItem(at: indexPath) else {
            return 0
        }
        let distanceFromCenter = visibleRect.midX - attributes.center.x
        return Double(-distanceFromCenter/(visibleRect.width))
    }
    
    private func updateTransformableCells() {
        collectionView?.visibleCells.forEach {
            guard let indexPath = collectionView?.indexPath(for: $0) else {
                return
            }
            let progress = getInterpolatedProgressForItem(indexPath: indexPath)
            ($0 as? TransformableView)?.transform(progress: progress)
        }
    }
    
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
