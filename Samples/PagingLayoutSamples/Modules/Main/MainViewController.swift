//
//  MainViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/26/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, NibBased {
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    // MARK: Event listeners
    
    @IBAction private func stackButtonTouched() {
        navigationController?.pushViewController(
            ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: .stack)),
            animated: true
        )
    }
    
    @IBAction private func scaleButtonTouched() {
        navigationController?.pushViewController(
            ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: .scale)),
            animated: true
        )
    }
    
    @IBAction private func snapshotButtonTouched() {
        navigationController?.pushViewController(
            ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: .snapshot)),
            animated: true
        )
    }
    
    @IBAction private func fruitsButtonTouched() {
        navigationController?.pushViewController(
            FruitsViewController.instantiate(viewModel: FruitsViewModel()),
            animated: true
        )
    }
    
    @IBAction private func galleryButtonTouched() {
        navigationController?.pushViewController(
            GalleryViewController.instantiate(viewModel: GalleryViewModel()),
            animated: true
        )
    }
    
    @IBAction private func cardsButtonTouched() {
        navigationController?.pushViewController(
            CardsViewController.instantiate(viewModel: CardsViewModel()),
            animated: true
        )
    }
    
}
