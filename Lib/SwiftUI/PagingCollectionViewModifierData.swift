//
//  PagingCollectionViewModifierData.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 10/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

struct PagingCollectionViewModifierData {
    var scaleOptions: ScaleTransformViewOptions?
    var stackOptions: StackTransformViewOptions?
    var snapshotOptions: SnapshotTransformViewOptions?
    var snapshotIdentifier: ((Int, UIView?) -> String)?
    var canReuseSnapshot: ((SnapshotContainerView, UIView?) -> Bool)?
    var numberOfVisibleItems: Int?
    var zPositionProvider: ((CGFloat) -> Int)?
    var animator: ViewAnimator?
    var goToSelectedPage: Bool?
    var collectionViewProperties: [CollectionViewPropertyProtocol] = []
    var onTapPage: ((Int) -> Void)?
    var scrollDirection: UICollectionView.ScrollDirection?
    var pagePadding: PagePadding?
    var transparentAttributeWhenCellNotLoaded: Bool?
}

protocol CollectionViewPropertyProtocol {
    func getKey<T>() -> WritableKeyPath<UICollectionView, T>?
    func getValue<T>() -> T?
}

struct CollectionViewProperty<T>: CollectionViewPropertyProtocol {
    let keyPath: WritableKeyPath<UICollectionView, T>
    let value: T

    func getKey<T>() -> WritableKeyPath<UICollectionView, T>? {
        keyPath as? WritableKeyPath<UICollectionView, T>
    }

    func getValue<T>() -> T? {
        value as? T
    }
}
