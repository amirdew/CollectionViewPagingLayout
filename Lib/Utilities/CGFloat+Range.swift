//
//  CGFloat+Range.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 2/22/20.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

extension CGFloat {
    
    public struct Range {
        
        let lower: CGFloat
        let upper: CGFloat
        
        public init(_ lower: CGFloat, _ upper: CGFloat) {
            self.lower = lower
            self.upper = upper
        }
    }
    
}
