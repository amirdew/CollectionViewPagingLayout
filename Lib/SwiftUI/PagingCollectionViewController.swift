//
//  PagingCollectionViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
public class PagingCollectionViewController<ValueType, ID: Hashable, PageContent: View>: UIViewController,
    UICollectionViewDataSource,
    CollectionViewPagingLayoutDelegate,
    UICollectionViewDelegate,
    UIScrollViewDelegate {

    // MARK: Properties

    var modifierData: PagingCollectionViewModifierData?
    var pageViewBuilder: ((ValueType, CGFloat) -> PageContent)!
    var onCurrentPageChanged: ((Int) -> Void)?

    private var collectionView: UICollectionView!
    private var list: [ValueType] = []
    private let layout = CollectionViewPagingLayout()


    // MARK: UIViewController

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout.invalidateLayoutWithPerformBatchUpdates()
    }


    // MARK: Public functions

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PagingCollectionViewCell<ValueType, ID, PageContent> = collectionView.dequeueReusableCellClass(for: indexPath)
        cell.update(value: list[indexPath.row], parent: self)
        return cell
    }

    public func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        onCurrentPageChanged?(currentPage)
    }

    public func collectionViewPagingLayout(_ layout: CollectionViewPagingLayout, didSelectItemAt indexPath: IndexPath) {
        onCurrentPageChanged(layout: layout, currentPage: indexPath.row)
    }


    // MARK: Internal functions

    func update(list: [ValueType], currentIndex: Int?) {
        self.list = list
        let index = currentIndex ?? layout.currentPage
        if index < list.count {
            guard index != layout.currentPage else { return }
            view.isUserInteractionEnabled = false
            layout.setCurrentPage(index) { [weak view] in
                view?.isUserInteractionEnabled = true
            }
        } else {
            layout.invalidateLayoutWithPerformBatchUpdates()
        }
    }


    // MARK: Private functions
    
    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: layout
        )
        layout.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.registerClass(PagingCollectionViewCell<ValueType, ID, PageContent>.self)
        collectionView.dataSource = self
        view.addSubview(collectionView)
        layout.configureTapOnCollectionView(goToSelectedPage: modifierData?.goToSelectedPage ?? true)
        layout.numberOfVisibleItems = modifierData?.numberOfVisibleItems
        layout.defaultAnimator = modifierData?.animator
        collectionView.delegate = self
        collectionView[keyPath: \.showsHorizontalScrollIndicator] = false
        modifierData?.collectionViewProperties?.forEach { property in
            if let keyPath: WritableKeyPath<UICollectionView, Bool> = property.getKey(),
               let value: Bool = property.getValue() {
                collectionView[keyPath: keyPath] = value
            }
            if let keyPath: WritableKeyPath<UICollectionView, UIView> = property.getKey(),
               let value: UIView = property.getValue() {
                collectionView[keyPath: keyPath] = value
            }
        }
    }


}


@available(iOS 13.0, *)
private extension UICollectionView {
    func registerClass<T: UICollectionViewCell>(_ cellType: T.Type, reuseIdentifier: String = T.reuseIdentifier) {
        register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func dequeueReusableCellClass<T: UICollectionViewCell>(for indexPath: IndexPath, type: T.Type? = nil, reuseIdentifier: String = T.reuseIdentifier) -> T {
        (dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T)!
    }
}


@available(iOS 13.0, *)
private extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
