//
//  TransformPageView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct TransformPageView<ValueType, ID: Hashable, PageContent: View>: UIViewControllerRepresentable, TransformPageViewProtocol {

    // MARK: Properties

    public var builder: Builder


    // MARK: Lifecycle

    public init(
        _ data: [ValueType],
        id: KeyPath<ValueType, ID>,
        selection: Binding<ID?>? = nil,
        @ViewBuilder viewBuilder: @escaping (ValueType, CGFloat) -> PageContent
    ) {
        builder = .init(data: data, pageViewBuilder: viewBuilder, selection: selection, idKeyPath: id)
    }
}
