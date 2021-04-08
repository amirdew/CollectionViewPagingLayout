//
//  PagingCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 20/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
class PagingCollectionViewCell<ValueType, ID: Hashable, Content: View>: UICollectionViewCell {

    typealias Parent = PagingCollectionViewController<ValueType, ID, Content>

    // MARK: Properties

    private weak var hostingController: UIHostingController<Content>?
    private var viewBuilder: ((ValueType, CGFloat) -> Content)?
    private var value: ValueType!
    private weak var parent: Parent?


    // MARK: Public functions

    func update(value: ValueType, parent: Parent) {
        self.parent = parent
        self.viewBuilder = parent.pageViewBuilder
        self.value = value
        if hostingController != nil {
            updateView()
        } else {
            let viewController = UIHostingController(rootView: updateView()!)
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


    // MARK: Private functions

    @discardableResult private func updateView(progress: CGFloat? = nil) -> Content? {
        guard let viewBuilder = viewBuilder
        else { return nil }

        let view = viewBuilder(value, progress ?? 0)
        hostingController?.rootView = view
        hostingController?.view.layoutIfNeeded()
        return view
    }
}


@available(iOS 13.0, *)
extension PagingCollectionViewCell: TransformableView,
                                    ScaleTransformView,
                                    StackTransformView,
                                    SnapshotTransformView {

    var scalableView: UIView {
        hostingController?.view ?? contentView
    }

    var cardView: UIView {
        hostingController?.view ?? contentView
    }

    var targetView: UIView {
        hostingController?.view ?? contentView
    }

    var selectableView: UIView? {
        scalableView
    }

    var scaleOptions: ScaleTransformViewOptions {
        parent?.modifierData?.scaleOptions ?? .init()
    }
    var stackOptions: StackTransformViewOptions {
        parent?.modifierData?.stackOptions ?? .init()
    }
    var snapshotOptions: SnapshotTransformViewOptions {
        parent?.modifierData?.snapshotOptions ?? .init()
    }

    func transform(progress: CGFloat) {
        if parent?.modifierData?.scaleOptions != nil {
            applyScaleTransform(progress: progress)
        }
        if parent?.modifierData?.stackOptions != nil {
            applyStackTransform(progress: progress)
        }
        if parent?.modifierData?.snapshotOptions != nil {
            if let snapshot = getSnapshot() {
                applySnapshotTransform(snapshot: snapshot, progress: progress)
            }
        }
        updateView(progress: progress)
    }

    func zPosition(progress: CGFloat) -> Int {
        parent?.modifierData?.zPositionProvider?(progress) ?? Int(-abs(round(progress)))
    }
}
