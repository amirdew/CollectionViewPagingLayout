//
//  CardsViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 01/10/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

class CardsViewController: UIViewController, NibBased, ViewModelBased {
    
    // MARK: Constants
    
    private struct Constants {
        
        static let collectionViewMaxItems = 100000
    }
    
    
    // MARK: Properties
    
    var viewModel: CardsViewModel!
    
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
        layout.goToPrevPage()
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        view.clipsToBounds = true
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.register(CardCollectionViewCell.self)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        layout.numberOfVisibleItems = 10
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
        collectionView.scrollToItem(at: .init(row: Constants.collectionViewMaxItems/2, section: 0), at: .centeredVertically, animated: false)
    }
    
}

extension CardsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constants.collectionViewMaxItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row % viewModel.itemViewModels.count
        let itemViewModel = viewModel.itemViewModels[index]
        let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.viewModel = itemViewModel
        return cell
    }

}

