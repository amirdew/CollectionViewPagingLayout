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
            ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: [
                .stackVortex,
                .stackRotary,
                .stackTransparent,
                .stackBlur,
                .stackReverse,
                .stackPerspective
            ])),
            animated: true
        )
    }
    
    @IBAction private func scaleButtonTouched() {
        navigationController?.pushViewController(
            ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: [
                .scaleCylinder,
                .scaleInvertedCylinder,
                .scaleCoverFlow,
                .scaleLinear,
                .scaleEaseIn,
                .scaleEaseOut,
                .scaleRotary,
                .scaleBlur,
            ])),
            animated: true
        )
    }
    
    @IBAction private func snapshotButtonTouched() {
        navigationController?.pushViewController(
            ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: [
                .snapshotBars,
                .snapshotFade,
                .snapshotGrid,
                .snapshotChess,
                .snapshotLines,
                .snapshotSpace,
                .snapshotTiles,
                .snapshotPuzzle
            ])),
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
