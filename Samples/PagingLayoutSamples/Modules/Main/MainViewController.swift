//
//  MainViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/26/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class MainViewController: UIViewController, NibBased {
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    @IBOutlet fileprivate weak var frameworkSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var transformTitleLabel: UILabel!
    @IBOutlet private var transformSubtitles: [UILabel]!
    @IBOutlet private weak var swiftUICustomBuildsContainer: UIView!
    @IBOutlet private weak var uiKitCustomBuildsContainer: UIView!

    private var isSwiftUI: Bool {
        frameworkSegmentedControl.selectedSegmentIndex == 0
    }


    // MARK: ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFrameworkSegmentedControl()
        updateViewsBasedOnSelectedFramework()
        swiftUICustomBuildsContainer.setNeedsLayout()
    }

    
    // MARK: Event listeners
    
    @IBAction private func stackButtonTouched() {
        if isSwiftUI {
            push(makeViewController(ShapesListView(layoutGroup: .stack),
                                    backButtonColor: .gray,
                                    statusBarStyle: .darkContent))
        } else {
            push(ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: .stack)))
        }
    }
    
    @IBAction private func scaleButtonTouched() {
        if isSwiftUI {
            push(makeViewController(ShapesListView(layoutGroup: .scale),
                                    backButtonColor: .gray,
                                    statusBarStyle: .darkContent))
        } else {
            push(ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: .scale)))
        }
    }
    
    @IBAction private func snapshotButtonTouched() {
        if isSwiftUI {
            push(makeViewController(ShapesListView(layoutGroup: .snapshot),
                                    backButtonColor: .gray,
                                    statusBarStyle: .darkContent))
        } else {
            push(ShapesViewController.instantiate(viewModel: ShapesViewModel(layouts: .snapshot)))
        }
    }
    
    @IBAction private func fruitsButtonTouched() {
        push(FruitsViewController.instantiate(viewModel: FruitsViewModel()))
    }
    
    @IBAction private func galleryButtonTouched() {
        push(GalleryViewController.instantiate(viewModel: GalleryViewModel()))
    }
    
    @IBAction private func cardsButtonTouched() {
        push(CardsViewController.instantiate(viewModel: CardsViewModel()))
    }

    @IBAction private func devicesButtonTouched() {
        push(makeViewController(DevicesView(), backButtonColor: .white, statusBarStyle: .lightContent))
    }

    @IBAction private func transportButtonTouched() {
        // TODO:
    }

    @IBAction private func weatherButtonTouched() {
        push(makeViewController(WeatherTabView(), backButtonColor: .gray, statusBarStyle: .darkContent))
    }

    @IBAction private func onFrameworkChanged() {
        updateViewsBasedOnSelectedFramework()
    }


    // MARK: Private functions

    private func configureFrameworkSegmentedControl() {
        frameworkSegmentedControl.overrideUserInterfaceStyle = .dark
    }

    private func updateViewsBasedOnSelectedFramework() {
        transformTitleLabel.text = isSwiftUI ? "PageView" : "Transforms"
        transformSubtitles.forEach { $0.text = transformTitleLabel.text }

        swiftUICustomBuildsContainer.isHidden = !isSwiftUI
        uiKitCustomBuildsContainer.isHidden = isSwiftUI
    }

    private func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func pop() {
        navigationController?.popViewController(animated: true)
    }

    private func makeViewController<T: View>(_ view: T,
                                             backButtonColor: UIColor?,
                                             statusBarStyle: UIStatusBarStyle?) -> UIViewController {
        let viewController = MainHostingViewController()
        viewController.statusBarStyle = statusBarStyle
        viewController.view.fill(with: UIHostingController(rootView: view).view)
        if let backButtonColor = backButtonColor {
            let backButton = UIButton(type: .custom)
            backButton.setImage(UIImage(systemName: "arrow.left.square.fill",
                                        withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)),
                                for: .normal)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(backButton)
            backButton.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 32).isActive = true
            backButton.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 19).isActive = true
            backButton.tintColor = backButtonColor
            backButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        }

        return viewController
    }
}


class MainHostingViewController: UIViewController {

    fileprivate var statusBarStyle: UIStatusBarStyle?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle ?? .lightContent
    }
}


class MainViewControllerScrollView: UIScrollView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let mainVC = superview?.next as? MainViewController {
            let point = convert(point, to: mainVC.view)
            if mainVC.frameworkSegmentedControl.frame.contains(point) {
                return mainVC.frameworkSegmentedControl.hitTest(point, with: event)
            }
        }
        return super.hitTest(point, with: event)
    }
}
