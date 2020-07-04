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
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    // MARK: Private functions
    
    private func configureViews() {
        let codeTextView = UITextView()
        codeTextView.backgroundColor = .clear
        codeTextView.isEditable = false
        view.fill(with: codeTextView, edges: .init(top: 20, left: 20, bottom: -20, right: -20))
        self.codeTextView = codeTextView
    }
    
    private func refreshViews() {
        codeTextView.attributedText = viewModel?.getHighlightedText()
    }
    
    
}
