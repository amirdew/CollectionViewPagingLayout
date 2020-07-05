//
//  CGFloat+String.swift
//  PagingLayoutSamples
//
//  Created by Amir on 28/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit


extension String {
    var floatValue: Float? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        formatter.maximumFractionDigits = 5
        formatter.locale = Locale(identifier: "en_US")
        let text = self.replacingOccurrences(of: ",", with: ".")
        let number = formatter.number(from: text)
        return number?.floatValue
    }
}

extension CGFloat {
    func format(fractionDigits: Int = 2) -> String {
        var formatted = String(format: "%.\(fractionDigits)f", self)
        if self == 0 {
            formatted = formatted.replacingOccurrences(of: "-0.00", with: "0.00")
        }
        return formatted
    }
}
