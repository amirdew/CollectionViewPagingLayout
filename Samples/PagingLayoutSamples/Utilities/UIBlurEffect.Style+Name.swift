//
//  UIBlurEffect.Style+Name.swift
//  PagingLayoutSamples
//
//  Created by Amir on 28/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

extension UIBlurEffect.Style {
    
    static var all: [UIBlurEffect.Style] {
        [.dark, .regular, .light]
    }
    
    static func by(name: String) -> UIBlurEffect.Style? {
        switch name.lowercased() {
        case "Dark".lowercased():
            return .dark
        case "Regular".lowercased():
            return .regular
        case "Light".lowercased():
            return .light
        default:
            return nil
        }
    }
    
    var name: String {
        switch self {
        case .dark:
            return "Dark"
        case .regular:
            return "Regular"
        case .light:
            return "Light"
        default:
            return ""
        }
    }
}
