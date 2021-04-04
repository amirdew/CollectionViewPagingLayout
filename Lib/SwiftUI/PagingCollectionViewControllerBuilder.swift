//
//  PagingCollectionViewControllerBuilder.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct PagingCollectionViewModifierData {
    var scaleOptions: ScaleTransformViewOptions?
    var stackOptions: StackTransformViewOptions?
    var snapshotOptions: SnapshotTransformViewOptions?
    var numberOfVisibleItems: Int?
    var zPositionProvider: ((CGFloat) -> Int)?
    var animator: ViewAnimator?
    var goToSelectedPage: Bool?
    var collectionViewProperties: [CollectionViewPropertyProtocol]?
}

@available(iOS 13.0, *)
protocol CollectionViewPropertyProtocol {
    func getKey<T>() -> WritableKeyPath<UICollectionView, T>?
    func getValue<T>() -> T?
}

@available(iOS 13.0, *)
struct CollectionViewProperty<T>: CollectionViewPropertyProtocol {
    let keyPath: WritableKeyPath<UICollectionView, T>
    let value: T

    func getKey<T>() -> WritableKeyPath<UICollectionView, T>? {
        return keyPath as? WritableKeyPath<UICollectionView, T>
    }

    func getValue<T>() -> T? {
        value as? T
    }
}

@available(iOS 13.0, *)
public class PagingCollectionViewControllerBuilder<ValueType, ID: Hashable, PageContent: View> {

    public typealias ViewController = PagingCollectionViewController<ValueType, ID, PageContent>

    // MARK: Properties

    let data: [ValueType]
    let pageViewBuilder: (ValueType, CGFloat) -> PageContent
    let selection: Binding<ID?>?
    let idKeyPath: KeyPath<ValueType, ID>

    var modifierData: PagingCollectionViewModifierData = .init()

    weak var viewController: ViewController?


    // MARK: Lifecycle

    public init(
        data: [ValueType],
        pageViewBuilder: @escaping (ValueType, CGFloat) -> PageContent,
        selection: Binding<ID?>?,
        idKeyPath: KeyPath<ValueType, ID>
    ) {
        self.data = data
        self.pageViewBuilder = pageViewBuilder
        self.selection = selection
        self.idKeyPath = idKeyPath
    }

    public init(
        data: [ValueType],
        pageViewBuilder: @escaping (ValueType) -> PageContent,
        selection: Binding<ID?>?,
        idKeyPath: KeyPath<ValueType, ID>
    ) {
        self.data = data
        self.pageViewBuilder = { value, _ in pageViewBuilder(value) }
        self.selection = selection
        self.idKeyPath = idKeyPath
    }


    // MARK: Public functions
    
    func make() -> ViewController {
        let viewController = ViewController()
        viewController.pageViewBuilder = pageViewBuilder
        viewController.modifierData = modifierData
        viewController.update(list: data, currentIndex: nil)
        viewController.onCurrentPageChanged = { [data, selection, idKeyPath] in
            guard $0 < data.count else { return }
            selection?.wrappedValue = data[$0][keyPath: idKeyPath]
        }
        return viewController
    }

    func update(viewController: ViewController) {
        let selectedIndex = data.enumerated().first {
            $0.element[keyPath: idKeyPath] == selection?.wrappedValue
        }?.offset
        viewController.modifierData = modifierData
        viewController.update(list: data, currentIndex: selectedIndex)
    }
}
