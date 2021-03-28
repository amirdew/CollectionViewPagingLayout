//
//  StackPageView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct StackPageView<ValueType, ID: Hashable, PageContent: View>: UIViewControllerRepresentable, TransformPageViewProtocol {

    // MARK: Properties

    public var builder: Builder


    // MARK: Lifecycle

    public init(
        _ data: [ValueType],
        id: KeyPath<ValueType, ID>,
        selection: Binding<ID?>? = nil,
        changePageOnSelect: Bool = false,
        @ViewBuilder viewBuilder: @escaping (ValueType) -> PageContent
    ) {
        builder = .init(data: data, pageViewBuilder: viewBuilder, selection: selection, idKeyPath: id)
        builder.modifierData.stackOptions = .init()
    }
}


@available(iOS 13.0, *)
public extension StackPageView {
    func options(_ options: StackTransformViewOptions) -> Self {
        builder.modifierData.stackOptions = options
        return self
    }
}
