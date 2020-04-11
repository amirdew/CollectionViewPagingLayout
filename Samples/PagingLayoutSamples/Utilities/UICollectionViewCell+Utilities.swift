//
//  UICollectionViewCell+Utilities.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 2/16/20.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

extension UICollectionView {

    // MARK: Public functions

    func registerClass<T: UICollectionViewCell>(_ cellType: T.Type, reuseIdentifier: String = T.reuseIdentifier) {
        register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCellClass<T: UICollectionViewCell>(for indexPath: IndexPath, type: T.Type? = nil, reuseIdentifier: String = T.reuseIdentifier) -> T {
        (dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T)!
    }

}


extension UICollectionViewCell {

    static var reuseIdentifier: String {
        String(describing: self)
    }

}
