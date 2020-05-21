//
//  LayoutDesignerOptionCell.swift
//  PagingLayoutSamples
//
//  Created by Amir on 19/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class LayoutDesignerOptionCell: UITableViewCell {
    
    // MARK: Properties
    
    var viewModel: LayoutDesignerOptionCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var slider1: UISlider!
    @IBOutlet private weak var slider2: UISlider!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var switchView: UISwitch!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
    }
    
    private func updateViews() {
    }
    
}

