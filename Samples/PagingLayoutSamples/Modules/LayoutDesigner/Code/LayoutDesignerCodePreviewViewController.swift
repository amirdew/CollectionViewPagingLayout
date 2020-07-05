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

class LayoutDesignerCodePreviewViewController: UIViewController {
 
    // MARK: Properties
    
    var viewModel: LayoutDesignerCodePreviewViewModel? {
        didSet {
            refreshViews()
        }
    }
    private weak var codeTextView: UITextView!
    private weak var copyButton: UIButton!
    private weak var codeModeSegmentedControl: UISegmentedControl!
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    // MARK: Listener
    
    @objc private func copyButtonTouched() {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = codeTextView.text
    }
    
    @objc private func codeTypeChanged() {
        refreshViews()
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        configureTextView()
        configureCopyButton()
        configureCodeTypeSegmentedControl()
    }
    
    private func configureCopyButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "copyButton"), for: .normal)
        button.addTarget(self, action: #selector(copyButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        copyButton = button
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        button.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    private func configureCodeTypeSegmentedControl() {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "ViewController", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Options variable", at: 0, animated: false)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        codeModeSegmentedControl = segmentedControl
        segmentedControl.topAnchor.constraint(equalTo: copyButton.topAnchor).isActive = true
        segmentedControl.rightAnchor.constraint(equalTo: copyButton.leftAnchor, constant: -10).isActive = true
        segmentedControl.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 20).isActive = true
        segmentedControl.heightAnchor.constraint(equalTo: copyButton.heightAnchor).isActive = true
        segmentedControl.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        segmentedControl.selectedSegmentTintColor = UIColor.white.withAlphaComponent(0.4)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black.withAlphaComponent(0.6)], for: .selected)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(codeTypeChanged), for: .valueChanged)
        
    }
    
    private func configureTextView() {
        let codeTextView = UITextView()
        codeTextView.backgroundColor = .clear
        codeTextView.isEditable = false
        view.fill(with: codeTextView, edges: .init(top: 100, left: 20, bottom: -20, right: -20))
        self.codeTextView = codeTextView
    }
    
    private func refreshViews() {
        codeTextView.attributedText = viewModel?.getHighlightedText(
            addViewControllerInCode: codeModeSegmentedControl.selectedSegmentIndex != 0
        )
    }
    
    
}
