//
//  PagingCollectionViewCell.swift
//  PagingLayoutSamples
//
//  Created by Amir on 20/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import UIKit
import SwiftUI
import CollectionViewPagingLayout

class PagingCollectionViewCell<Content: View>: UICollectionViewCell, ScaleTransformView {

    var scaleOptions: ScaleTransformViewOptions!

    private weak var hostingController: UIHostingController<Content>?

    func update(_ view: Content, parent: UIViewController) {
        if let controller = hostingController {
            controller.rootView = view
            controller.view.layoutIfNeeded()
        } else {
            let viewController = UIHostingController(rootView: view)
            hostingController = viewController
            viewController.view.backgroundColor = .clear

            parent.addChild(viewController)
            contentView.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true

            viewController.didMove(toParent: parent)
            viewController.view.layoutIfNeeded()
        }
    }
}
