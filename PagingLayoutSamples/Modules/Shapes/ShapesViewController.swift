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
    
    // MARK: Properties
    
    var viewModel: ShapesViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layoutTypeCollectionView: UICollectionView!
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        collectionView.registerClass(ScaleLinearShapeCollectionViewCell.self)
        collectionView.registerClass(ScaleEaseInShapeCollectionViewCell.self)
        collectionView.registerClass(ScaleEaseOutShapeCollectionViewCell.self)
        collectionView.registerClass(ScalePerspectiveShapeCollectionViewCell.self)
        
        collectionView.registerClass(DefaultStackShapeCollectionViewCell.self)
        
        collectionView.registerClass(DefaultSnapshotShapeCollectionViewCell.self)
        
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        let layout = CollectionViewPagingLayout()
        layout.numberOfVisibleItems = 5
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
    
    private func getShapeCell(collectionView: UICollectionView, for indexPath: IndexPath) -> BaseShapeCollectionViewCell {
        
        switch viewModel.selectedLayoutMode {
        case .scalePerspective:
            return collectionView.dequeueReusableCellClass(for: indexPath) as ScalePerspectiveShapeCollectionViewCell
            
        case .scaleLinear:
            return collectionView.dequeueReusableCellClass(for: indexPath) as ScaleLinearShapeCollectionViewCell
            
        case .scaleEaseIn:
            return collectionView.dequeueReusableCellClass(for: indexPath) as ScaleEaseInShapeCollectionViewCell
            
        case .scaleEaseOut:
            return collectionView.dequeueReusableCellClass(for: indexPath) as ScaleEaseOutShapeCollectionViewCell
            
        case .stackDefault:
            return collectionView.dequeueReusableCellClass(for: indexPath) as DefaultStackShapeCollectionViewCell
                
        case .snapshotDefault:
            return collectionView.dequeueReusableCellClass(for: indexPath) as DefaultSnapshotShapeCollectionViewCell
        }
    }
}

extension ShapesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == layoutTypeCollectionView {
            return viewModel.layoutTypeViewModels.count
        }
        if collectionView == self.collectionView {
            return viewModel.shapeViewModels.count
        }
        
        fatalError("unknown collection view")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == layoutTypeCollectionView {
            let itemViewModel = viewModel.layoutTypeViewModels[indexPath.row]
            let cell: LayoutTypeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = itemViewModel
            return cell
        }
        
        if collectionView == self.collectionView {
            let itemViewModel = viewModel.shapeViewModels[indexPath.row]
            let cell = getShapeCell(collectionView: collectionView, for: indexPath)
            cell.viewModel = itemViewModel
            return cell
        }
        
        fatalError("unknown collection view")
    }
    
}


extension ShapesViewController: CollectionViewPagingLayoutDelegate {
    
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        self.viewModel.selectedLayoutMode = self.viewModel.layoutTypeViewModels[currentPage].layout
        self.collectionView.reloadData()
        
        collectionView.performBatchUpdates({
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}
