//
//  LayoutDesignerOptionCell.swift
//  PagingLayoutSamples
//
//  Created by Amir on 19/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class LayoutDesignerOptionCell: UITableViewCell, NibBased {
    
    // MARK: Properties
    
    var viewModel: LayoutDesignerOptionCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var slider1: UISlider!
    @IBOutlet private weak var input1: UITextField!
    @IBOutlet private weak var slider2: UISlider!
    @IBOutlet private weak var input2: UITextField!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var switchView: UISwitch!
    @IBOutlet private weak var equalWidthConstraint: NSLayoutConstraint!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        backgroundColor = .clear
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        [slider1, slider2].forEach {
            $0?.tintColor = .white
            $0?.thumbTintColor = .white
            $0?.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.3)
            $0?.minimumTrackTintColor = .white
        }
        
        equalWidthConstraint.isActive = false
        label.text = "Min scale"
        slider1.isHidden = false
        input1.isHidden = false
        slider2.isHidden = true
        input2.isHidden = true
        segmentedControl.isHidden = true
        switchView.isHidden = true
    }
    
    private func updateViews() {
    }
    
}
