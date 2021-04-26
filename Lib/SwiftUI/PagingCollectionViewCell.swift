//
//  PagingCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 20/03/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

#if canImport(SwiftUI) && canImport(Combine)
import UIKit
import SwiftUI

@available(iOS 13.0, *)
class PagingCollectionViewCell<ValueType: Identifiable, Content: View>: UICollectionViewCell {

    typealias Parent = PagingCollectionViewController<ValueType, Content>

    // MARK: Properties

    private weak var hostingController: UIHostingController<Content>?
    private var viewBuilder: ((ValueType, CGFloat) -> Content)?
    private var value: ValueType!
    private var index: IndexPath!
    private weak var parent: Parent?
    private var parentBoundsObserver: NSKeyValueObservation?
    private var parentSize: CGSize?

    // MARK: Public functions

    func update(value: ValueType, index: IndexPath, parent: Parent) {
        self.parent = parent
        self.viewBuilder = parent.pageViewBuilder
        self.value = value
        self.index = index
        if hostingController != nil {
            updateView()
        } else {
            let viewController = UIHostingController(rootView: updateView()!)
            hostingController = viewController
            viewController.view.backgroundColor = .clear

            parent.addChild(viewController)
            contentView.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false

            parentBoundsObserver = parent.view
                .observe(\.bounds, options: [.initial, .new, .old, .prior]) { [weak self] _, _ in
                    self?.updatePagePaddings()
                }

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

    private func updatePagePaddings() {
        guard let parent = parent,
              let viewController = hostingController,
              parent.view.bounds.size != parentSize
        else { return }

        parentSize = parent.view.bounds.size

        func constraint<T>(_ first: NSLayoutAnchor<T>,
                           _ second: NSLayoutAnchor<T>,
                           _ paddingKeyPath: KeyPath<PagePadding, PagePadding.Padding?>,
                           _ inside: Bool) {
            let padding = parent.modifierData?.pagePadding?[keyPath: paddingKeyPath] ?? .absolute(0)
            let constant: CGFloat
            switch padding {
            case .fractionalWidth(let fraction):
                constant = parent.view.bounds.size.width * fraction
            case .fractionalHeight(let fraction):
                constant = parent.view.bounds.size.height * fraction
            case .absolute(let absolute):
                constant = absolute
            }
            let identifier = "pagePaddingConstraint_\(inside)_\(T.self)"
            if let constraint = contentView.constraints.first(where: { $0.identifier == identifier }) ??
                viewController.view.constraints.first(where: { $0.identifier == identifier }) {
                constraint.constant = constant * (inside ? 1 : -1)
            } else {
                let constraint = first.constraint(equalTo: second, constant: constant * (inside ? 1 : -1))
                constraint.identifier = identifier
                constraint.isActive = true
            }
        }

        constraint(contentView.leadingAnchor, viewController.view.leadingAnchor, \.left, false)
        constraint(contentView.trailingAnchor, viewController.view.trailingAnchor, \.right, true)
        constraint(contentView.topAnchor, viewController.view.topAnchor, \.top, false)
        constraint(contentView.bottomAnchor, viewController.view.bottomAnchor, \.bottom, true)
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

    var snapshotIdentifier: String {
        if let snapshotIdentifier = parent?.modifierData?.snapshotIdentifier {
            return snapshotIdentifier(index.item, hostingController?.view)
        }

        var identifier = String(describing: value.id)

        if let scrollView = targetView as? UIScrollView {
            identifier.append("\(scrollView.contentOffset)")
        }

        if let scrollView = targetView.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            identifier.append("\(scrollView.contentOffset)")
        }

        return identifier
    }

    func canReuse(snapshot: SnapshotContainerView) -> Bool {
        if let canReuse = parent?.modifierData?.canReuseSnapshot {
            return canReuse(snapshot, hostingController?.view)
        }
        return snapshot.snapshotSize == targetView.bounds.size
    }
}
#endif
