//
//  Temporal.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public protocol Temporal {

    ///
    /// Get the number of milli seconds since the UNIX epoch
    ///
    func toMillis() -> Int64

    /// Add the amount to this temporal
    func + (lhs: Self, rhs: TemporalAmount) -> Self

    /// Subtract the amount from this temporal
    func - (lhs: Self, rhs: TemporalAmount) -> Self

    /// Get the difference between two temporals
    func - <T : Temporal>(lhs: Self, rhs: T) -> TemporalAmount
}