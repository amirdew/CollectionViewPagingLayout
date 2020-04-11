//
//  Multipliable.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public protocol MultipliableToCGFloat {
    static func * (rhs: Self, lhs: CGFloat) -> Self
    static func * (rhs: CGFloat, lhs: Self) -> Self
}

public protocol SummableToCGFloat {
    static func + (rhs: Self, lhs: CGFloat) -> Self
    static func + (rhs: CGFloat, lhs: Self) -> Self
}

public protocol MultipliableToSelf {
    static func * (rhs: Self, lhs: Self) -> Self
}

public protocol SummableToSelf {
    static func + (rhs: Self, lhs: Self) -> Self
}

extension CGFloat: MultipliableToCGFloat, MultipliableToSelf, SummableToCGFloat, SummableToSelf {}


extension CGPoint: MultipliableToCGFloat, MultipliableToSelf {
    public static func * (rhs: CGFloat, lhs: CGPoint) -> CGPoint {
        lhs * rhs
    }
    public static func * (rhs: CGPoint, lhs: CGFloat) -> CGPoint {
        CGPoint(x: rhs.x * lhs, y: rhs.y * lhs)
    }
    public static func * (rhs: CGPoint, lhs: CGPoint) -> CGPoint {
        CGPoint(x: rhs.x * lhs.x, y: rhs.y * lhs.y)
    }
}

extension CGPoint: SummableToCGFloat, SummableToSelf {
    public static func + (rhs: CGFloat, lhs: CGPoint) -> CGPoint {
        lhs + rhs
    }
    public static func + (rhs: CGPoint, lhs: CGFloat) -> CGPoint {
        CGPoint(x: rhs.x + lhs, y: rhs.y + lhs)
    }
    public static func + (rhs: CGPoint, lhs: CGPoint) -> CGPoint {
        CGPoint(x: rhs.x + lhs.x, y: rhs.y + lhs.y)
    }
}


extension CGSize: MultipliableToCGFloat, MultipliableToSelf {
    public static func * (rhs: CGFloat, lhs: CGSize) -> CGSize {
        lhs * rhs
    }
    public static func * (rhs: CGSize, lhs: CGFloat) -> CGSize {
        CGSize(width: rhs.width * lhs, height: rhs.height * lhs)
    }
    public static func * (rhs: CGSize, lhs: CGSize) -> CGSize {
        CGSize(width: rhs.width * lhs.width, height: rhs.height * lhs.height)
    }
}

extension CGSize: SummableToCGFloat, SummableToSelf {
    public static func + (rhs: CGFloat, lhs: CGSize) -> CGSize {
        lhs + rhs
    }
    public static func + (rhs: CGSize, lhs: CGFloat) -> CGSize {
        CGSize(width: rhs.width + lhs, height: rhs.height + lhs)
    }
    public static func + (rhs: CGSize, lhs: CGSize) -> CGSize {
        CGSize(width: rhs.width + lhs.width, height: rhs.height + lhs.height)
    }
}
