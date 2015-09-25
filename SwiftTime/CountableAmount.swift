//
//  CountableAmount.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 25.09.2015.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//


public protocol CountableType {
    var count: Int64 { get set }

    init(_ count: Int64)
}

public func ==<T : CountableType>(lhs: T, rhs: T) -> Bool {
    return lhs.count == rhs.count
}

public func + <T : CountableType> (lhs: T, rhs: T) -> T {
    return T(rhs.count + lhs.count)
}

public func - <T : CountableType> (lhs: T, rhs: T) -> T {
    return T(rhs.count - lhs.count)
}

public func += <T : CountableType> (inout lhs: T, rhs: T) {
    lhs.count += rhs.count
}

public func -= <T : CountableType> (inout lhs: T, rhs: T) {
    lhs.count -= rhs.count
}