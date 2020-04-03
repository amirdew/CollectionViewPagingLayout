//
//  ShapesViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class ShapesViewController: UIViewController, NibBased, ViewModelBased {
    
    // MARK: Constants
    
    private struct Constants {
        
        static let infiniteNumberOfItems = 100000
    }
    
    
    // MARK: Properties
    
    var viewModel: ShapesViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layoutTypeCollectionView: UICollectionView!
    
    private var didScrollCollectionViewToMiddle = false
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didScrollCollectionViewToMiddle {
            let layout = layoutTypeCollectionView.collectionViewLayout as? CollectionViewPagingLayout
            layout?.setCurrentPage(Constants.infiniteNumberOfItems / 2, animated: false)
            didScrollCollectionViewToMiddle = true
        }
        
        collectionView.collectionViewLayout.invalidateLayout()
        layoutTypeCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: Event listener
    
    @IBAction private func onBackTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        view.clipsToBounds = true
        configureCollectionView()
        configureLayoutTypeCollectionView()
    }
    
    private func configureCollectionView() {
        ShapesViewModel.allLayoutViewModes.forEach {
            collectionView.registerClass($0.cellClass, reuseIdentifier: "\($0.layout)")
        }
        
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        let layout = CollectionViewPagingLayout()
        layout.numberOfVisibleItems = 10
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
    }
    
    private func configureLayoutTypeCollectionView() {
        layoutTypeCollectionView.register(LayoutTypeCollectionViewCell.self)
        layoutTypeCollectionView.isPagingEnabled = true
        layoutTypeCollectionView.dataSource = self
        let layout = CollectionViewPagingLayout()
        layout.numberOfVisibleItems = 5
        layout.delegate = self
        layoutTypeCollectionView.collectionViewLayout = layout
        layoutTypeCollectionView.showsHorizontalScrollIndicator = false
        layoutTypeCollectionView.clipsToBounds = false
        layoutTypeCollectionView.backgroundColor = .clear
    }
}

extension ShapesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == layoutTypeCollectionView {
            return Constants.infiniteNumberOfItems
        }
        if collectionView == self.collectionView {
            return viewModel.selectedLayout.cardViewModels.count
        }
        
        fatalError("unknown collection view")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == layoutTypeCollectionView {
            let itemViewModel = viewModel.layoutTypeViewModels[indexPath.row % viewModel.layoutTypeViewModels.count]
            let cell: LayoutTypeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = itemViewModel
            return cell
        }
        
        if collectionView == self.collectionView {
            let itemViewModel = viewModel.selectedLayout.cardViewModels[indexPath.row]
            let cell = collectionView.dequeueReusableCellClass(for: indexPath, type: viewModel.selectedLayout.cellClass, reuseIdentifier: "\(viewModel.selectedLayout.layout)")
            cell.viewModel = itemViewModel
            return cell
        }
        
        fatalError("unknown collection view")
    }
    
}


extension ShapesViewController: CollectionViewPagingLayoutDelegate {
    
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        let index = currentPage % viewModel.layoutTypeViewModels.count
        self.viewModel.selectedLayout = self.viewModel.layoutTypeViewModels[index]
        self.collectionView.reloadData()
        
        collectionView.performBatchUpdates({
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}
