//
//  ShapesViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

protocol ShapesViewControllerDelegate: AnyObject {
    func shapesViewController(_ vc: ShapesViewController, onSelectedLayoutChange layout: ShapeLayout)
}


class ShapesViewController: UIViewController, NibBased, ViewModelBased {
    
    // MARK: Constants
    
    private struct Constants {
        
        static let infiniteNumberOfItems = 100_000
    }
    
    
    // MARK: Properties
    
    var viewModel: ShapesViewModel! {
        didSet {
            updateSelectedLayout()
            reloadDataAndLayouts()
        }
    }
    
    weak var delegate: ShapesViewControllerDelegate?
    
    @IBOutlet private weak var backButton: UIButton!
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
            getPagingLayout(layoutTypeCollectionView)?.setCurrentPage(
                Constants.infiniteNumberOfItems / 2,
                animated: false
            )
            didScrollCollectionViewToMiddle = true
        }
        
        updateSelectedLayout()
        invalidateLayouts()
    }
    
    
    // MARK: Event listener
    
    @IBAction private func onBackTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        view.clipsToBounds = true
        backButton.isHidden = !viewModel.showBackButton
        configureCollectionView()
        configureLayoutTypeCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.registerClass(StackShapeCollectionViewCell.self)
        collectionView.registerClass(ScaleShapeCollectionViewCell.self)
        collectionView.registerClass(SnapshotShapeCollectionViewCell.self)
        
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        let layout = CollectionViewPagingLayout()
        layout.numberOfVisibleItems = 10
        collectionView.collectionViewLayout = layout
        layout.configureTapOnCollectionView(goToSelectedPage: true)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
    }
    
    private func configureLayoutTypeCollectionView() {
        layoutTypeCollectionView.register(LayoutTypeCollectionViewCell.self)
        layoutTypeCollectionView.isPagingEnabled = true
        layoutTypeCollectionView.dataSource = self
        let layout = CollectionViewPagingLayout()
        layout.numberOfVisibleItems = 10
        layoutTypeCollectionView.collectionViewLayout = layout
        layout.configureTapOnCollectionView(goToSelectedPage: true)
        layoutTypeCollectionView.showsHorizontalScrollIndicator = false
        layoutTypeCollectionView.clipsToBounds = false
        layoutTypeCollectionView.backgroundColor = .clear
        layoutTypeCollectionView.delegate = self
    }
    
    private func updateSelectedLayout() {
        guard let layout = layoutTypeCollectionView?.collectionViewLayout as? CollectionViewPagingLayout else {
            return
        }
        let index = layout.currentPage % viewModel.layoutTypeViewModels.count
        self.viewModel.selectedLayout = self.viewModel.layoutTypeViewModels[index]
        delegate?.shapesViewController(self, onSelectedLayoutChange: viewModel.selectedLayout.layout)
        collectionView.reloadData()
        collectionView.performBatchUpdates({
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
    private func reloadDataAndLayouts() {
        layoutTypeCollectionView?.reloadData()
        collectionView?.reloadData()
        invalidateLayouts()
    }
    
    private func invalidateLayouts() {
        layoutTypeCollectionView?.performBatchUpdates({
            self.layoutTypeCollectionView.collectionViewLayout.invalidateLayout()
        })
        collectionView?.performBatchUpdates({
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
    
    private func getPagingLayout(_ collectionView: UICollectionView) -> CollectionViewPagingLayout? {
        collectionView.collectionViewLayout as? CollectionViewPagingLayout
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
            var cell: BaseShapeCollectionViewCell!
            if ShapeLayout.scaleLayouts.contains(viewModel.selectedLayout.layout) {
                cell = collectionView.dequeueReusableCellClass(for: indexPath) as ScaleShapeCollectionViewCell
                
            } else if ShapeLayout.stackLayouts.contains(viewModel.selectedLayout.layout) {
                cell = collectionView.dequeueReusableCellClass(for: indexPath) as StackShapeCollectionViewCell
                
            } else if ShapeLayout.snapshotLayouts.contains(viewModel.selectedLayout.layout) {
                cell = collectionView.dequeueReusableCellClass(for: indexPath) as SnapshotShapeCollectionViewCell
            }
            
            cell.viewModel = itemViewModel
            return cell
        }
        
        fatalError("unknown collection view")
    }
    
}


extension ShapesViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == layoutTypeCollectionView else {
            return
        }
        if !decelerate {
            updateSelectedLayout()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == layoutTypeCollectionView else {
            return
        }
        updateSelectedLayout()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard scrollView == layoutTypeCollectionView else {
            return
        }
        updateSelectedLayout()
    }
}
