//
//  StackPageView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 28/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

#if canImport(SwiftUI) && canImport(Combine)
import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct StackPageView<ValueType: Identifiable, PageContent: View>: UIViewControllerRepresentable, TransformPageViewProtocol {

    // MARK: Properties

    public var builder: Builder


    // MARK: Lifecycle

    public init(
        _ data: [ValueType],
        selection: Binding<ValueType.ID?>? = nil,
        @ViewBuilder viewBuilder: @escaping (ValueType) -> PageContent
    ) {
        builder = .init(data: data, pageViewBuilder: viewBuilder, selection: selection)
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
#endif
