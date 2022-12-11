//
//  TransformPageViewProtocol.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import Foundation
import SwiftUI

public protocol TransformPageViewProtocol {
    associatedtype ValueType: Identifiable
    associatedtype PageContent: View

    typealias Builder = PagingCollectionViewControllerBuilder<ValueType, PageContent>
    
    var builder: Builder { get }
}


public extension TransformPageViewProtocol {
    func numberOfVisibleItems(_ count: Int) -> Self {
        self.builder.modifierData.numberOfVisibleItems = count
        return self
    }

    func zPosition(_ zPosition: @escaping (CGFloat) -> Int) -> Self {
        self.builder.modifierData.zPositionProvider = zPosition
        return self
    }

    func onTapPage(_ onTapPage: @escaping (ValueType.ID) -> Void) -> Self {
        self.builder.modifierData.onTapPage = { index in
            guard index < builder.data.count else { return }
            onTapPage(builder.data[index].id)
        }
        return self
    }

    func pagePadding(top: PagePadding.Padding? = nil,
                     left: PagePadding.Padding? = nil,
                     bottom: PagePadding.Padding? = nil,
                     right: PagePadding.Padding? = nil) -> Self {
        let current = self.builder.modifierData.pagePadding
        let topPadding: PagePadding.Padding? = {
            if let top = top {
                return top
            } else {
                return current?.top
            }
        }()
        
        let leftPadding: PagePadding.Padding? = {
            if let left = left {
                return left
            } else {
                return current?.left
            }
        }()
        
        let bottomPadding: PagePadding.Padding? = {
            if let bottom = bottom {
                return bottom
            } else {
                return current?.bottom
            }
        }()
        
        let rightPadding: PagePadding.Padding? = {
            if let right = right {
                return right
            } else {
                return current?.right
            }
        }()
        
        self.builder.modifierData.pagePadding = .init(
            top: topPadding,
            left: leftPadding,
            bottom: bottomPadding,
            right: rightPadding
        )
        return self
    }

    func pagePadding(_ padding: PagePadding.Padding? = nil) -> Self {
        pagePadding(vertical: padding, horizontal: padding)
    }

    func pagePadding(vertical: PagePadding.Padding? = nil,
                     horizontal: PagePadding.Padding? = nil) -> Self {
        let current = self.builder.modifierData.pagePadding
        
        let topPadding: PagePadding.Padding? = {
            if let top = vertical {
                return top
            } else {
                return current?.top
            }
        }()
        
        let leftPadding: PagePadding.Padding? = {
            if let left = horizontal {
                return left
            } else {
                return current?.left
            }
        }()
        
        let bottomPadding: PagePadding.Padding? = {
            if let bottom = vertical {
                return bottom
            } else {
                return current?.bottom
            }
        }()
        
        let rightPadding: PagePadding.Padding? = {
            if let right = horizontal {
                return right
            } else {
                return current?.right
            }
        }()
        
        self.builder.modifierData.pagePadding = .init(
            top: topPadding,
            left: leftPadding,
            bottom: bottomPadding,
            right: rightPadding
        )
        return self
    }

    func animator(_ animator: ViewAnimator) -> Self {
        self.builder.modifierData.animator = animator
        return self
    }

    func scrollToSelectedPage(_ goToSelectedPage: Bool) -> Self {
        self.builder.modifierData.goToSelectedPage = goToSelectedPage
        return self
    }

    func scrollDirection(_ direction: UICollectionView.ScrollDirection) -> Self {
        self.builder.modifierData.scrollDirection = direction
        return self
    }

    func hideCellWhenNotLoaded(_ value: Bool) -> Self {
        self.builder.modifierData.transparentAttributeWhenCellNotLoaded = value
        return self
    }

    func collectionView<T>(_ key: WritableKeyPath<UICollectionView, T>, _ value: T) -> Self {
        let property = CollectionViewProperty(keyPath: key, value: value)
        self.builder.modifierData.collectionViewProperties.append(property)
        return self
    }
}


public extension TransformPageViewProtocol where Self: UIViewControllerRepresentable {
     func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> Builder.ViewController {
        builder.make()
    }

    func updateUIViewController(_ uiViewController: Builder.ViewController, context: Context) {
        builder.update(viewController: uiViewController)
    }
}
