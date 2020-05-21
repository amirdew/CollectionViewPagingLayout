//
//  UITableView+Utilities.swift
//  PagingLayoutSamples
//
//  Created by Amir on 21/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

extension UITableView {

    // MARK: Public functions

    func registerClass<T: UITableViewCell>(_ cellType: T.Type, reuseIdentifier: String = T.reuseIdentifier) {
        register(cellType, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCellClass<T: UITableViewCell>(for indexPath: IndexPath, type: T.Type? = nil, reuseIdentifier: String = T.reuseIdentifier) -> T {
        (dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T)!
    }

}


extension UITableViewCell {

    static var reuseIdentifier: String {
        String(describing: self)
    }

}
