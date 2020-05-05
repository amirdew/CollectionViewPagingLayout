//
//  UIWindow+Size.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 19/04/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

extension UIWindow {
    
    static var firstWindowSize: CGSize {
        UIApplication.shared.windows.first!.bounds.size
    }
}
