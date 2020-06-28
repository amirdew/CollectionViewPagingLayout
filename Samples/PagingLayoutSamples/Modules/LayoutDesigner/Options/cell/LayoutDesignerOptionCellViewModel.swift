//
//  LayoutDesignerOptionCellViewModel.swift
//  PagingLayoutSamples
//
//  Created by Amir on 19/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

class LayoutDesignerOptionCellViewModel {
    
    // MARK: Constants
    
    enum Kind {
        case singleSlider(current: CGFloat, onChange: (CGFloat) -> Void)
        case doubleSlider(current: (CGFloat, CGFloat), onChange: (CGFloat, CGFloat) -> Void)
        case toggleSwitch(current: Bool, onChange: (Bool) -> Void)
        case segmented(options: [String], current: String?, onChange: (String) -> Void)
    }
    
    
    // MARK: Properties
    
    let title: String
    let kind: Kind
    
    
    // MARK: Lifecycle
    
    init(title: String, kind: Kind) {
        self.title = title
        self.kind = kind
    }
    
}
