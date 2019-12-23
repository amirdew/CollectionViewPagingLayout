//
//  NibBased.swift
//  ViewPagerFlowLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation
import UIKit

protocol NibBased {

    // MARK: Static parameters

    static var nibName: String { get }

}


extension NibBased {

    // MARK: Static parameters

    static var nibName: String {
        return String(describing: self)
    }

}


extension NibBased where Self: UIViewController {

    // MARK: Static functions

    static func instantiate() -> Self {
        return Self.init(nibName: self.nibName, bundle: Bundle(for: self))
    }

}


extension NibBased where Self: UICollectionViewCell {

    // MARK: Static properties

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}


extension UICollectionView {

    // MARK: Public functions

    func register<T: UICollectionViewCell & NibBased>(_ cellType: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell & NibBased>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

}
