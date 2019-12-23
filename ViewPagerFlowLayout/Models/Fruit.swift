//
//  Fruit.swift
//  ViewPagerFlowLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

struct Fruit {
    
    // MARK: Properties
    
    let title: String
    let description: String
    let isVegan: Bool
    let price: Double
    let priceType: PriceType
    let tintColor: UIColor
    let imageName: String
}


extension Fruit {
    
    enum PriceType {
        case unit
        case kilogram
    }
}
