//
//  LayoutDesignerIntroViewController.swift
//  PagingLayoutSamples
//
//  Created by Amir on 09/07/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class LayoutDesignerIntroViewController: UIViewController {
 
    // MARK: Properties
    
    var viewModel: LayoutDesignerIntroViewModel? {
        didSet {
            refreshViews()
        }
    }
    private var collectionView: UICollectionView!
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        open()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.performBatchUpdates({ [weak self] in
                self?.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }
    }
    
    
    // MARK: Private functions
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewPagingLayout())
        collectionView.isPagingEnabled = true
        collectionView.register(LayoutDesignerIntroCell.self)
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 44
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alpha = 0
        
        let darkOverlay = UIView()
        darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.59)
        view.fill(with: darkOverlay)
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        darkOverlay.addGestureRecognizer(tap)
        darkOverlay.alpha = 0
        
        view.addSubview(collectionView)
        collectionView.widthAnchor.constraint(equalToConstant: 950).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        darkOverlay.center(to: collectionView)
    }
    
    private func refreshViews() {
        collectionView?.reloadData()
    }
    
    private func open() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.view.subviews.forEach {
                $0.alpha = 1
            }
        }
    }
    
    @objc private func close() {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.view.subviews.forEach {
                $0.alpha = 0
            }
        }, completion: { [weak self] _ in
            self?.view.removeFromSuperview()
            self?.didMove(toParent: nil)
        })
    }
    
}


extension LayoutDesignerIntroViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.introPages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as LayoutDesignerIntroCell
        cell.introInfo = viewModel?.introPages[indexPath.row]
        cell.delegate = self
        return cell
    }
}


extension LayoutDesignerIntroViewController: LayoutDesignerIntroCellDelegate {
    func layoutDesignerIntroCell(_ cell: LayoutDesignerIntroCell, onLeftButtonTouched button: UIButton) {
        if collectionView.indexPath(for: cell)?.item == 0 {
            close()
            return
        }
        (collectionView.collectionViewLayout as? CollectionViewPagingLayout)?.goToPreviousPage()
    }
    func layoutDesignerIntroCell(_ cell: LayoutDesignerIntroCell, onRightButtonTouched button: UIButton) {
        if collectionView.indexPath(for: cell)?.item == viewModel.map({ $0.introPages.count - 1 }) {
            close()
            return
        }
        (collectionView.collectionViewLayout as? CollectionViewPagingLayout)?.goToNextPage()
    }
}
