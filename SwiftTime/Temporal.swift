//
//  Temporal.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public protocol Temporal : Equatable {
    func add(unit: TemporalUnit, amount: Int64) -> Self
    func add(amount: TemporalAmount) -> Self
    func +(lhs: Self, rhs: TemporalAmount) -> Self
}

extension Temporal {
    func add(unit: TemporalUnit) -> Self {
        return add(unit, amount: 1)
    }
}

public func +<T : Temporal> (lhs: T, rhs: TemporalAmount) -> T {
    return lhs.add(rhs)
}