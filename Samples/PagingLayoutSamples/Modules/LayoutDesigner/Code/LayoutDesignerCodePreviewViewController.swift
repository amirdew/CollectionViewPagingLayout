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

protocol LayoutDesignerCodePreviewViewControllerDelegate: AnyObject {
    func layoutDesignerCodePreviewViewController(_ vc: LayoutDesignerCodePreviewViewController, onHelpButtonTouched button: UIButton)
}


class LayoutDesignerCodePreviewViewController: UIViewController, NibBased, ViewModelBased {
 
    // MARK: Properties
    
    var viewModel: LayoutDesignerCodePreviewViewModel! {
        didSet {
            refreshViews()
        }
    }
    weak var delegate: LayoutDesignerCodePreviewViewControllerDelegate?
    
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
        guard let exportURL = viewModel.sampleProjectTempURL else { return }
        viewModel.generateSampleProject()
        let controller = UIDocumentPickerViewController(url: exportURL, in: UIDocumentPickerMode.exportToService)
        controller.delegate = self
        present(controller, animated: true)
    }
    
    @IBAction private func onHelpButtonTouched() {
        delegate?.layoutDesignerCodePreviewViewController(self, onHelpButtonTouched: helpButton)
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


extension LayoutDesignerCodePreviewViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        controller.dismiss(animated: true)
        viewModel.removeSampleProject()
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
        viewModel.removeSampleProject()
    }
}
