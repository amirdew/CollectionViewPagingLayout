//
//  PriceTagView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/26/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit

class PriceTagView: UIView, NibBased {
    
    // MARK: Properties
    
    var price: Double? { didSet { updatePrice() } }
    var priceType: Fruit.PriceType? { didSet { updatePriceType() } }
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceTypeLabel: UILabel!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceTypeLabel.font = .systemFont(ofSize: 22, weight: .light)
        priceTypeLabel.textColor = UIColor.black.withAlphaComponent(0.23)
    }
    
    
    // MARK: Private functions
    
    private func updatePrice() {
        guard let price = price else {
            priceLabel.text = ""
            return
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"

        let formattedPrice = formatter.string(from: NSNumber(value: price)) ?? ""
        let dotIndex = formattedPrice.range(of: ".")!.upperBound
        let firstPartRange = NSRange(formattedPrice.startIndex...dotIndex, in: formattedPrice)
        let secondPartRange = NSRange(dotIndex..<formattedPrice.endIndex, in: formattedPrice)
        let attributedText = NSMutableAttributedString(string: formattedPrice)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 30, weight: .semibold), range: firstPartRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.black.withAlphaComponent(0.69), range: firstPartRange)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .regular), range: secondPartRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.black.withAlphaComponent(0.49), range: secondPartRange)
        priceLabel.attributedText = attributedText
    }
    
    private func updatePriceType() {
        guard let priceType = priceType else {
            priceTypeLabel.text = ""
            return
        }
        priceTypeLabel.text = priceType.localizedDescription
    }
    
}
