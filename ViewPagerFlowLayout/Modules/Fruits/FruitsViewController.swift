//
//  FruitsViewController.swift
//  ViewPagerFlowLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

class FruitsViewController: UIViewController, NibBased, ViewModelBased {
    
    // MARK: Properties
    
    var viewModel: FruitsViewModel!
    
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
    
    // MARK: Private functions
    
    private func configureViews() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.register(FruitsCollectionViewCell.self)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = ViewPagerFlowLayout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
    }
    
}


extension FruitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
}


extension FruitsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.items[indexPath.row]
        let cell: FruitsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.viewModel = FruitCellViewModel(fruit: item)
        return cell
    }

}


extension FruitsViewController: ViewPagerFlowLayoutDelegate {
    
    func onCurrentPageChanged(layout: ViewPagerFlowLayout, currentPage: Int) {
        
    }
    
}
