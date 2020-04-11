//
//  Optional+Let.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation

extension Optional {
    func `let`<T>(_ transform: (Wrapped) -> T?) -> T? {
        if case .some(let value) = self {
            return transform(value)
        }
        return nil
    }
}
