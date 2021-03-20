//
//  MyCardsView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 30/01/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI
import CollectionViewPagingLayout

struct MyCardsView: View {

    @State var selectedCardImageName: String?

    private let cards: [Card] = [
        Card(imageName: "card01"),
        Card(imageName: "card02"),
        Card(imageName: "card06"),
        Card(imageName: "card07"),
        Card(imageName: "card08")
    ]

    var body: some View {
        PagingCollectionView(cards,
                             id: \.imageName,
                             selection: $selectedCardImageName) { card in
            Image(card.imageName)
        }
        .onChange(of: selectedCardImageName) {
            print($0)
        }
    }
}

// LazyTransformPageView() { object, transform in  }
// LazyScalePageView(options: ScaleOptions) { object in  }

enum PagingViewTag {
    static let targetView = "PagingViewTargetViewTag"
}

struct PagingCollectionView<ValueType, ID: Hashable, PageContent: View>: UIViewControllerRepresentable {

    typealias ViewController = PagingCollectionViewController<ValueType, ID, PageContent>
    let data: [ValueType]
    let pageViewBuilder: (ValueType) -> PageContent
    private let selection: Binding<ID?>?
    private let idKeyPath: KeyPath<ValueType, ID>

    public init(
        _ data: [ValueType],
        id: KeyPath<ValueType, ID>,
        selection: Binding<ID?>? = nil,
        changePageOnSelect: Bool = false,
        @ViewBuilder pageContent: @escaping (ValueType) -> PageContent) {
        self.data = data
        self.pageViewBuilder = pageContent
        self.selection = selection
        self.idKeyPath = id
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<PagingCollectionView>) -> ViewController {
        let viewController = ViewController()
        viewController.pageViewBuilder = pageViewBuilder
        viewController.update(list: data, currentIndex: nil)
        viewController.onCurrentPageChanged = {
            guard $0 < data.count else { return }
            selection?.wrappedValue = data[$0][keyPath: idKeyPath]
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        let selectedIndex = data.enumerated().first {
            $0.element[keyPath: idKeyPath] == selection?.wrappedValue
        }?.offset
        uiViewController.update(list: data, currentIndex: selectedIndex)
    }
}

class PagingCollectionViewController<ValueType, ID: Hashable, PageContent: View>: UIViewController, UICollectionViewDataSource, CollectionViewPagingLayoutDelegate {

    var pageViewBuilder: ((ValueType) -> PageContent)!
    var onCurrentPageChanged: ((Int) -> Void)?
    private var collectionView: UICollectionView!
    private var list: [ValueType] = []
    private let layout = CollectionViewPagingLayout()
    private var currentPage: Int?
    private var syncCurrentPage: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: layout
        )
        layout.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.registerClass(PagingCollectionViewCell<PageContent>.self)
        collectionView.dataSource = self
        view.addSubview(collectionView)
        layout.configureTapOnCollectionView(goToSelectedPage: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.performBatchUpdates({ [weak self] in
                self?.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
    }

    func update(list: [ValueType], currentIndex: Int?) {
        self.list = list
        let index = currentIndex ?? currentPage ?? 0
        if index < list.count {
            guard index != currentPage else { return }
            syncCurrentPage = index
            view.isUserInteractionEnabled = false
        	layout.setCurrentPage(index)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView?.performBatchUpdates({ [weak self] in
                    self?.collectionView?.collectionViewLayout.invalidateLayout()
                })
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PagingCollectionViewCell<PageContent> = collectionView.dequeueReusableCellClass(for: indexPath)
        cell.update(pageViewBuilder(list[indexPath.row]), parent: self)
        return cell
    }

    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        self.currentPage = currentPage
        if syncCurrentPage != nil {
            if currentPage == syncCurrentPage {
                syncCurrentPage = nil
                view.isUserInteractionEnabled = true
            }
            return
        }
        onCurrentPageChanged?(currentPage)
    }

    func collectionViewPagingLayout(_ layout: CollectionViewPagingLayout, didSelectItemAt indexPath: IndexPath) {
        onCurrentPageChanged(layout: layout, currentPage: indexPath.row)
    }
}


class PagingCollectionViewCell<Content: View>: UICollectionViewCell, ScaleTransformView {

    var scaleOptions = ScaleTransformViewOptions(
        minScale: 1.20,
        maxScale: 1.20,
        scaleRatio: 0.00,
        translationRatio: .zero,
        minTranslationRatio: .zero,
        maxTranslationRatio: .zero,
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: true,
        scaleCurve: .linear,
        translationCurve: .linear,
        shadowEnabled: false,
        shadowColor: .black,
        shadowOpacity: 0.60,
        shadowRadiusMin: 2.00,
        shadowRadiusMax: 13.00,
        shadowOffsetMin: .init(width: 0.00, height: 2.00),
        shadowOffsetMax: .init(width: 0.00, height: 6.00),
        shadowOpacityMin: 0.10,
        shadowOpacityMax: 0.10,
        blurEffectEnabled: false,
        blurEffectRadiusRatio: 0.40,
        blurEffectStyle: .light,
        rotation3d: .init(
            angle: 1.05,
            minAngle: -3.14,
            maxAngle: 3.14,
            x: 0.00,
            y: -1.00,
            z: 0.00,
            m34: -0.002_000
        ),
        translation3d: .init(
            translateRatios: (0.10, 0.00, 0.00),
            minTranslateRatios: (-0.05, 0.00, 0.86),
            maxTranslateRatios: (0.05, 0.00, -0.86)
        )
    )

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
