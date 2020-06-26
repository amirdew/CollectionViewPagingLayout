//
//  LayoutDesignerOptionCellViewModel.swift
//  PagingLayoutSamples
//
//  Created by Amir on 19/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation

class LayoutDesignerOptionCellViewModel {
    
    // MARK: Constants
    
    enum Kind {
        case singleSlider
        case doubleSlider
        case toggleSwitch
        case segmented([String])
    }
    
    
    // MARK: Properties
    
    let kind: Kind
    
    
    // MARK: Lifecycle
    
    init(kind: Kind) {
        self.kind = kind
    }
    
}
