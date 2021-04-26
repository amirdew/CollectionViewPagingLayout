//
//  TransformPageView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//
#if canImport(SwiftUI) && canImport(Combine)
import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct TransformPageView<ValueType: Identifiable, PageContent: View>: UIViewControllerRepresentable, TransformPageViewProtocol {

    // MARK: Properties

    public var builder: Builder


    // MARK: Lifecycle

    public init(
        _ data: [ValueType],
        selection: Binding<ValueType.ID?>? = nil,
        @ViewBuilder viewBuilder: @escaping (ValueType, CGFloat) -> PageContent
    ) {
        builder = .init(data: data, pageViewBuilder: viewBuilder, selection: selection)
    }
}
#endif
