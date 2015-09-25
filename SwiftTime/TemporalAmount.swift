//
//  Duration.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

///
/// An amount of time
///
public protocol TemporalAmount {
    /// Amount of months
    var months: Int64 { get }

    /// Amount of days
    var days: Int64 { get }

    /// Amount of seconds
    var seconds: Int64 { get }

    /// Amount of nano seconds. The value returned from this
    /// accessor should never be larger than 999,999,999
    var nanoSeconds: Int32 { get }

    /// Convenience method to get all components of this
    /// amount
    func components() -> (Int64, Int64, Int64, Int32)
}

public func == (lhs: TemporalAmount, rhs: TemporalAmount) -> Bool {
    let (aM, aD, aS, aN) = lhs.components()
    let (bM, bD, bS, bN) = rhs.components()

    return aM == bM && aD == bD && aS == bS && aN == bN
}

///
/// Add two amounts together
///
public func + (lhs: TemporalAmount, rhs: TemporalAmount) -> TemporalAmount {
    var nanoSeconds = lhs.nanoSeconds + rhs.nanoSeconds
    var seconds = lhs.seconds + rhs.seconds
    seconds += Int64(nanoSeconds / NANOS_PER_SECONDS)
    nanoSeconds = nanoSeconds % NANOS_PER_SECONDS

    let days = lhs.days + rhs.days
    let months = lhs.months + rhs.months

    return Duration(days, months, seconds, nanoSeconds)
}

///
/// Subtract the second amount from the first
///
public func - (lhs: TemporalAmount, rhs: TemporalAmount) -> TemporalAmount {
    var nanoSeconds = lhs.nanoSeconds - rhs.nanoSeconds
    var seconds = lhs.seconds - rhs.seconds
    seconds += Int64(nanoSeconds / NANOS_PER_SECONDS)
    nanoSeconds = nanoSeconds % NANOS_PER_SECONDS

    let days = lhs.days - rhs.days
    let months = lhs.months - rhs.months

    return Duration(days, months, seconds, nanoSeconds)
}