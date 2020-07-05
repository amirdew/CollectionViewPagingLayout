//
//  LayoutDesignerViewController.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 05/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import Splash

class LayoutDesignerViewController: UIViewController, ViewModelBased, NibBased {
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: Properties
    
    var viewModel: LayoutDesignerViewModel!
    
    @IBOutlet private weak var stackButtonView: UIView!
    @IBOutlet private weak var scaleButtonView: UIView!
    @IBOutlet private weak var snapshotButtonView: UIView!
    @IBOutlet private weak var previewContainerView: UIView!
    @IBOutlet private weak var codeContainerView: UIView!
    @IBOutlet private weak var optionsTableView: LayoutDesignerOptionsTableView!
    
    private var previewViewController: ShapesViewController!
    private var codePreviewViewController: LayoutDesignerCodePreviewViewController!
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setOptionsList()
        registerKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: Event listeners
    
    @IBAction private func layoutCategoryButtonTouched(button: UIButton) {
        guard let view = button.superview else { return }
        
        switch view {
        case stackButtonView:
            viewModel.layouts = .stack
        case scaleButtonView:
            viewModel.layouts = .scale
        case snapshotButtonView:
            viewModel.layouts = .snapshot
        default:
            viewModel.layouts = []
        }
        previewViewController.viewModel = viewModel.shapesViewModel
        
        setLayoutButtonSelected(view: stackButtonView, isSelected: view == stackButtonView)
        setLayoutButtonSelected(view: scaleButtonView, isSelected: view == scaleButtonView)
        setLayoutButtonSelected(view: snapshotButtonView, isSelected: view == snapshotButtonView)
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            view.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        setInitialStateForLayoutButtons()
        addPreviewController()
        addCodePreviewController()
    }
    
    private func setInitialStateForLayoutButtons() {
        setLayoutButtonSelected(view: stackButtonView, isSelected: false)
        setLayoutButtonSelected(view: scaleButtonView, isSelected: true)
        setLayoutButtonSelected(view: snapshotButtonView, isSelected: false)
    }
    
    private func setLayoutButtonSelected(view: UIView, isSelected: Bool, animated: Bool = true) {
        guard let titleStackView = view.subviews.first(where: { $0 is UIStackView })?
            .subviews.first(where: { $0 is UIStackView }) else {
                return
        }
        titleStackView.isHidden = !isSelected
        
        let borderColor = UIColor.white.withAlphaComponent(0.66).cgColor
        let noBorderColor = UIColor.clear.cgColor
        
        let oldBorderColor = view.layer.borderColor
        view.layer.borderColor = isSelected ? borderColor : noBorderColor
        
        guard animated else {
            return
        }
        let borderAnimation = CABasicAnimation(keyPath: "borderColor")
        borderAnimation.duration = 0.4
        borderAnimation.fromValue = oldBorderColor
        borderAnimation.toValue = view.layer.borderColor
        view.layer.add(borderAnimation, forKey: nil)
    }
    
    private func addPreviewController() {
        previewViewController = ShapesViewController.instantiate(viewModel: viewModel.shapesViewModel)
        addChild(previewViewController)
        previewViewController.view.layer.cornerRadius = 30
        previewViewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        previewContainerView.fill(with: previewViewController.view)
        previewViewController.didMove(toParent: self)
        previewViewController.delegate = self
        viewModel.onOptionsChange = { [weak self] in
            self?.previewViewController.reloadAndInvalidateShapes()
        }
    }
    
    private func addCodePreviewController() {
        codePreviewViewController = LayoutDesignerCodePreviewViewController()
        addChild(codePreviewViewController)
        codeContainerView.fill(with: codePreviewViewController.view)
        codePreviewViewController.didMove(toParent: self)
        viewModel.onCodePreviewViewModelChange = { [weak self] in
            self?.codePreviewViewController.viewModel = $0
        }
    }
    
    private func setOptionsList() {
        optionsTableView.optionViewModels = viewModel.optionViewModels
    }
    
    private func registerKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        var contentInset = optionsTableView.contentInset
        
        if keyboardViewEndFrame.minY < optionsTableView.frame.maxY {
            contentInset.bottom = optionsTableView.frame.maxY - keyboardViewEndFrame.minY - 8
        } else {
            contentInset.bottom = 8
        }
        optionsTableView.contentInset = contentInset
    }
    
}


extension LayoutDesignerViewController: ShapesViewControllerDelegate {
    func shapesViewController(_ vc: ShapesViewController, onSelectedLayoutChange layout: ShapeLayout) {
        viewModel.selectedLayout = layout
        setOptionsList()
    }
}
