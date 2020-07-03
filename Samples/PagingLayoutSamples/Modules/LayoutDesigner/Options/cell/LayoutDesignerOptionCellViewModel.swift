//
//  LayoutDesignerOptionCellViewModel.swift
//  PagingLayoutSamples
//
//  Created by Amir on 19/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

class LayoutDesignerOptionSectionViewModel {
    
    // MARK: Properties
    
    let title: String
    var items: [LayoutDesignerOptionViewModel]
    
    
    // MARK: Lifecycle
    
    init(title: String, items: [LayoutDesignerOptionViewModel]) {
        self.title = title
        self.items = items
    }
}


class LayoutDesignerOptionViewModel {
    
    // MARK: Constants
    
    enum Kind {
        case singleSlider(current: CGFloat?, range: ClosedRange<CGFloat> = 0...1, optional: Bool = false, onChange: (CGFloat?) -> Void)
        case doubleSlider(current: (CGFloat, CGFloat)?, range: ClosedRange<CGFloat> = 0...1, optional: Bool = false, onChange: ((CGFloat, CGFloat)?) -> Void)
        case toggleSwitch(current: Bool, onChange: (Bool) -> Void)
        case segmented(options: [String], current: String, onChange: (String) -> Void)
    }
    
    
    // MARK: Properties
    
    let title: String
    let kind: Kind
    
    private var changed: Bool = false
    private var latestValue: Any?
    
    
    // MARK: Lifecycle
    
    init(title: String, kind: Kind) {
        self.title = title
        self.kind = kind
    }
    
    
    // MARK: Public functions
    
    func onNewValue(_ value: Any?) {
        changed = true
        latestValue = value
    }
    
    func getLatestValue<T>() -> T? {
        if !changed {
            return nil
        }
        return latestValue as? T
    }
    
}
