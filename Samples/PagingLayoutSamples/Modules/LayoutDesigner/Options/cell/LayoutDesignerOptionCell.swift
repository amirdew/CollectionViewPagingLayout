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
    private var equalWidthConstraint: NSLayoutConstraint?
    
    private var onSlider1Change: (CGFloat) -> Void = { _ in }
    private var onInput1Change: (CGFloat) -> Void = { _ in }
    private var onSlider2Change: (CGFloat) -> Void = { _ in }
    private var onInput2Change: (CGFloat) -> Void = { _ in }
    private var onSwitchChange: (Bool) -> Void = { _ in }
    private var onSelectedSegmentChange: (Int) -> Void = { _ in }
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        updateViews()
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
            $0?.addTarget(self, action: #selector(onSliderChange(slider:)), for: .valueChanged)
        }
        [input1, input2].forEach {
            $0?.backgroundColor = .white
            $0?.textAlignment = .center
            $0?.layer.cornerRadius = 8
            $0?.addTarget(self, action: #selector(onInputChange(input:)), for: .editingChanged)
            $0?.keyboardType = .decimalPad
        }
        switchView.onTintColor = .systemGreen
        switchView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        switchView.layer.cornerRadius = switchView.layer.bounds.height / 2
        switchView.addTarget(self, action: #selector(onSwitchChange(switchView:)), for: .valueChanged)
        
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.3098039216, green: 0.5215686275, blue: 0.8666666667, alpha: 1)], for: .selected)
        segmentedControl.tintColor = .white
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        segmentedControl.addTarget(self, action: #selector(onSelectedSegmentChange(control:)), for: .valueChanged)
    }
    
    @objc private func onSwitchChange(switchView: UISwitch) {
        onSwitchChange(switchView.isOn)
    }
    
    @objc private func onSelectedSegmentChange(control: UISegmentedControl) {
        onSelectedSegmentChange(control.selectedSegmentIndex)
    }
    
    @objc private func onInputChange(input: UITextField) {
        onInputChange(input: input, fromSlider: false)
    }
    
    @objc private func onSliderChange(slider: UISlider) {
        onSliderChange(slider: slider, fromInput: false)
    }
    
    private func onSliderChange(slider: UISlider, fromInput: Bool) {
        let value = CGFloat(slider.value)
        if slider == slider1, !(slider1.value == Float(value) && fromInput) {
            onSlider1Change(value)
            onInputChange(input: input1, fromSlider: true)
            input1.set(value: value)
        } else if slider == slider2, !(slider2.value == Float(value) && fromInput) {
            onSlider2Change(value)
            onInputChange(input: input2, fromSlider: true)
            input2.set(value: value)
        }
    }
    
    private func onInputChange(input: UITextField, fromSlider: Bool) {
        let value = input.floatValue
        if input == input1, !(input1.floatValue == value && fromSlider) {
            onInput1Change(CGFloat(value))
            onSliderChange(slider: slider1, fromInput: true)
            slider1.value = value
        } else if input == input2, !(input2.floatValue == value && fromSlider) {
            onInput2Change(CGFloat(value))
            onSliderChange(slider: slider2, fromInput: true)
            slider2.value = value
        }
    }
    
    private func updateViews() {
        guard let viewModel = viewModel, label != nil else { return }
        
        label.text = viewModel.title
        slider1.isHidden = true
        input1.isHidden = true
        slider2.isHidden = true
        input2.isHidden = true
        segmentedControl.isHidden = true
        switchView.isHidden = true
        equalWidthConstraint?.isActive = false
        slider2.superview?.isHidden = true
        
        switch viewModel.kind {
            
        case let .singleSlider(current, onChange):
            slider1.isHidden = false
            input1.isHidden = false
            input1.set(value: current)
            slider1.value = Float(current)
            onSlider1Change = onChange
            
        case let .doubleSlider(current, onChange):
            equalWidthConstraint = slider1.widthAnchor.constraint(equalTo: slider2.widthAnchor, multiplier: 1)
            equalWidthConstraint?.isActive = true
            slider1.isHidden = false
            input1.isHidden = false
            slider2.superview?.isHidden = false
            input1.set(value: current.0)
            slider1.value = Float(current.0)
            slider2.isHidden = false
            input2.isHidden = false
            input2.set(value: current.1)
            slider2.value = Float(current.1)
            onSlider1Change = { [weak self] in onChange($0, CGFloat(self?.slider2.value ?? 0)) }
            onSlider2Change = { [weak self] in onChange(CGFloat(self?.slider1.value ?? 0), $0) }
            onInput1Change = { [weak self] in onChange($0, CGFloat(self?.input2.floatValue ?? 0)) }
            onInput2Change = { [weak self] in onChange(CGFloat(self?.input1.floatValue ?? 0), $0) }
            
        case let .toggleSwitch(current, onChange):
            switchView.isHidden = false
            switchView.isOn = current
            onSwitchChange = onChange
            
        case let .segmented(options, current, onChange):
            segmentedControl.isHidden = false
            segmentedControl.removeAllSegments()
            options.reversed().forEach {
                segmentedControl.insertSegment(withTitle: $0, at: 0, animated: false)
            }
            onSelectedSegmentChange = { onChange(options[$0]) }
            if let current = current, let index = options.firstIndex(of: current) {
                segmentedControl.selectedSegmentIndex = index
            }
        }
    }
    
}


private extension UITextField {
    
    var floatValue: Float {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        let text = self.text?.replacingOccurrences(of: ",", with: ".") ?? "0"
        let number = formatter.number(from: text)
        return number?.floatValue ?? 0
    }
    
    func set(value: Float) {
        set(value: CGFloat(value))
    }
    
    func set(value: CGFloat) {
        text = String(format: "%.2f", value)
    }
}
