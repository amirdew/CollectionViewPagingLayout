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
            ZStack {
                Image(card.imageName)
                Text(card.imageName)
            }
            .cornerRadius(17)
        }
        .onChange(of: selectedCardImageName) {
            print($0 ?? "")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                selectedCardImageName = "card07"
            }
        }
    }
}

// TransformPageView() { object, transform in  }
// ScalePageView(options: ScaleOptions) { object in  }

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
        @ViewBuilder pageContent: @escaping (ValueType) -> PageContent
    ) {
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

class PagingCollectionViewController<ValueType, ID: Hashable, PageContent: View>: UIViewController,
    UICollectionViewDataSource,
    CollectionViewPagingLayoutDelegate,
    UICollectionViewDelegate,
    UIScrollViewDelegate {

    var pageViewBuilder: ((ValueType) -> PageContent)!
    var onCurrentPageChanged: ((Int) -> Void)?
    private var collectionView: UICollectionView!
    private var list: [ValueType] = []
    private let layout = CollectionViewPagingLayout()

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
        collectionView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout.invalidateLayoutWithPerformBatchUpdates()
    }

    func update(list: [ValueType], currentIndex: Int?) {
        self.list = list
        let index = currentIndex ?? layout.currentPage
        if index < list.count {
            guard index != layout.currentPage else { return }
            view.isUserInteractionEnabled = false
            layout.setCurrentPage(index) { [weak view] in
                view?.isUserInteractionEnabled = true
            }
        } else {
            layout.invalidateLayoutWithPerformBatchUpdates()
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
        onCurrentPageChanged?(currentPage)
    }

    func collectionViewPagingLayout(_ layout: CollectionViewPagingLayout, didSelectItemAt indexPath: IndexPath) {
        onCurrentPageChanged(layout: layout, currentPage: indexPath.row)
    }

}
