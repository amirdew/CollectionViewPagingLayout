//
//  SnapshotPageView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import Foundation
import SwiftUI

public struct SnapshotPageView<ValueType: Identifiable, PageContent: View>: UIViewControllerRepresentable, TransformPageViewProtocol {

    // MARK: Properties

    public var builder: Builder


    // MARK: Lifecycle

    public init(
        _ data: [ValueType],
        selection: Binding<ValueType.ID?>? = nil,
        @ViewBuilder viewBuilder: @escaping (ValueType) -> PageContent
    ) {
        builder = .init(data: data, pageViewBuilder: viewBuilder, selection: selection)
        builder.modifierData.snapshotOptions = .init()
    }
}


public extension SnapshotPageView {
    func options(_ options: SnapshotTransformViewOptions) -> Self {
        builder.modifierData.snapshotOptions = options
        return self
    }
}

public extension SnapshotPageView {
    /// A unique identifier for the snapshot, a new snapshot won't be made if
    /// there is a cashed snapshot with the same identifier
    /// - Parameter index: The index of item
    /// - Parameter view: The `UIView` converted from `PageContent`
    /// - Returns: Self
    func snapshotIdentifier(_ snapshotIdentifier: @escaping (_ index: Int, _ view: UIView?) -> String) -> Self {
        builder.modifierData.snapshotIdentifier = snapshotIdentifier
        return self
    }
}

public extension SnapshotPageView {
    /// Check if the snapshot can be reused
    /// - Parameter snapshotContainer: The container for snapshot pieces, see `SnapshotContainerView`
    /// - Parameter view: The `UIView` converted from `PageContent`
    /// - Returns: Self
    func canReuseSnapshot(_ canReuseSnapshot: @escaping (_ snapshotContainer: SnapshotContainerView, _ view: UIView?) -> Bool) -> Self {
        builder.modifierData.canReuseSnapshot = canReuseSnapshot
        return self
    }
}
