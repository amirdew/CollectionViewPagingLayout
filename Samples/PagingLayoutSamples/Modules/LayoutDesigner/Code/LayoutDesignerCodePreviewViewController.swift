//
//  LayoutDesignerCodePreviewViewController.swift
//  PagingLayoutSamples
//
//  Created by Amir on 26/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit
import Splash

class LayoutDesignerCodePreviewViewController: UIViewController, NibBased, ViewModelBased {
 
    // MARK: Properties
    
    var viewModel: LayoutDesignerCodePreviewViewModel! {
        didSet {
            refreshViews()
        }
    }
    @IBOutlet private weak var codeTextView: UITextView!
    @IBOutlet private weak var copyButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var helpButton: UIButton!
    @IBOutlet private weak var codeModeSegmentedControl: UISegmentedControl!
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    // MARK: Listener
    
    @IBAction private func copyButtonTouched() {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = codeTextView.text
    }
    
    @IBAction private func saveButtonTouched() {
        refreshViews()
    }
    
    @IBAction private func onHelpButtonTouched() {
    }
    
    @IBAction private func codeTypeChanged() {
        refreshViews()
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        configureTextView()
        configureButtons()
        configureCodeTypeSegmentedControl()
    }
    
    private func configureButtons() {
        [saveButton, copyButton, helpButton].forEach {
            $0?.layer.cornerRadius = 8
        }
    }
    
    private func configureCodeTypeSegmentedControl() {
        codeModeSegmentedControl.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        codeModeSegmentedControl.selectedSegmentTintColor = UIColor.white.withAlphaComponent(0.4)
        codeModeSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        codeModeSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black.withAlphaComponent(0.6)], for: .selected)
        codeModeSegmentedControl.selectedSegmentIndex = 0
        
    }
    
    private func configureTextView() {
        codeTextView.backgroundColor = .clear
        codeTextView.isEditable = false
    }
    
    private func refreshViews() {
        codeTextView.attributedText = viewModel?.getHighlightedText(
            addViewControllerInCode: codeModeSegmentedControl.selectedSegmentIndex == 0
        )
    }
    
    
}
