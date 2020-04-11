//
//  GalleryViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/27/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit
import CollectionViewPagingLayout

class GalleryViewController: UIViewController, NibBased, ViewModelBased {
    
    // MARK: Properties
    
    var viewModel: GalleryViewModel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private let layout = CollectionViewPagingLayout()
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    // MARK: Event listener
    
    @IBAction private func onBackTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func onNextTouched() {
        layout.goToNextPage()
    }
    
    @IBAction private func onPreviousTouched() {
        layout.goToPreviousPage()
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        view.backgroundColor = .black
        view.clipsToBounds = true
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.register(PhotoCollectionViewCell.self)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        layout.numberOfVisibleItems = 10
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
    }
    
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemViewModel = viewModel.itemViewModels[indexPath.row]
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.viewModel = itemViewModel
        return cell
    }

}
