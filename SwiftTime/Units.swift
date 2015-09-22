//
//  Units.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

/**
A unit of time
*/
public protocol TemporalUnit {
    /**
    Get the number of this unit between the two temporals
    */
    //static func between<T : Temporal>(start: T, and: T) -> Int64
}

///
/// A protocol for time deltas that are represented by a count of a single unit.
/// E.g. 5 hours or 10 minutes
///
public protocol CountableType : TemporalAmountMath, Equatable {
    /// The count that this time delta contains
    var count: Int64 { get set }

    /// Initialized that sets the count
    init(_ count: Int64)
}

public func ==<T : CountableType>(lhs: T, rhs: T) -> Bool {
    return lhs.count == rhs.count
}

public func +<T : CountableType>(lhs: T, rhs: T) -> T {
    return lhs.add(rhs)
}

public func +<T : CountableType>(lhs: Int, rhs: T) -> T {
    return rhs.add(T(Int64(lhs)))
}

public func +<T : CountableType>(lhs: T, rhs: Int) -> T {
    return lhs.add(T(Int64(rhs)))
}

public func -<T : CountableType>(lhs: T, rhs: T) -> T {
    return lhs.subtract(rhs)
}

public func -<T : CountableType>(lhs: Int, rhs: T) -> T {
    return rhs.subtract(T(Int64(lhs)))
}

public func -<T : CountableType>(lhs: T, rhs: Int) -> T {
    return lhs.subtract(T(Int64(rhs)))
}

public func *<T : CountableType>(lhs: T, rhs: Int) -> T {
    return lhs.multiply(rhs)
}

public func /<T : CountableType>(lhs: T, rhs: Int) -> T {
    return lhs.divide(rhs)
}

public func +=<T : CountableType>(inout lhs: T, rhs: T) {
    lhs.count += rhs.count
}

public func -=<T : CountableType>(inout lhs: T, rhs: T) {
    lhs.count -= rhs.count
}

public func /=<T : CountableType>(inout lhs: T, divider: Int) {
    lhs.count /= Int64(divider)
}

public func *=<T : CountableType>(inout lhs: T, factor: Int) {
    lhs.count *= Int64(factor)
}

public prefix func - <T : CountableType>(amount: T) -> T {
    return T(-amount.count)
}

public extension CountableType {
    final func add(other: Self) -> Self {
        return Self(self.count + other.count)
    }

    final func subtract(other: Self) -> Self {
        return Self(self.count + other.count)
    }

    final func multiply(factor: Int) -> Self {
        return Self(self.count * Int64(factor))
    }

    final func divide(divider: Int) -> Self {
        return Self(self.count / Int64(divider))
    }
}

///
/// A protocol for time amounts that can be represented as a number of months
///
public protocol MonthType {
    var months: Int64 { get }
}


///
/// A protocol for time amounts that can be represented as a number of days
///
public protocol DayType {
    var days: Int64 { get }
}


///
/// A protocol for time amounts that can be representated as a number of seconds
///
public protocol SecondType {
    var seconds: Int64 { get }
}

public extension SecondType {
    final func add<T : SecondType>(other: T) -> Seconds {
        return Seconds(self.seconds + other.seconds)
    }

    final func subtract<T : SecondType>(other: T) -> Seconds {
        return Seconds(self.seconds - other.seconds)
    }
}

public func +<T : SecondType, U : SecondType> (lhs: T, rhs: U) -> Seconds {
    return lhs.add(rhs)
}

public func -<T : SecondType, U : SecondType> (lhs: T, rhs: U) -> Seconds {
    return lhs.subtract(rhs)
}

///
/// A protocol for time amounts that can be representated as a number of nano seconds
///
public protocol NanoSecondType {
    var nanoSeconds: Int64 { get }
}

public extension NanoSecondType {
    final func add<T : NanoSecondType>(other: T) -> NanoSeconds {
        return NanoSeconds(self.nanoSeconds + other.nanoSeconds)
    }

    final func subtract<T : NanoSecondType>(other: T) -> NanoSeconds {
        return NanoSeconds(self.nanoSeconds - other.nanoSeconds)
    }
}

public func +<T : NanoSecondType, U : NanoSecondType> (lhs: T, rhs: U) -> NanoSeconds {
    return lhs.add(rhs)
}

public func -<T : NanoSecondType, U : NanoSecondType> (lhs: T, rhs: U) -> NanoSeconds {
    return lhs.subtract(rhs)
}

//
// MARK: Structs
//

///
/// A unit representing a number of years
///
public struct Years: CountableType, MonthType {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public var months: Int64 {
        return self.count * 12
    }

    public func supports(field: TemporalUnit) -> Bool {
        switch field {
        case is Years:
            return true
        default:
            return false
        }
    }

    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Years:
            return count
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
}

///
/// A unit representing a number of months
///
public struct Months: CountableType, MonthType {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public var months: Int64 {
        return self.count
    }


    public func supports(field: TemporalUnit) -> Bool {
        switch field {
        case is Months:
            return true
        default:
            return false
        }
    }

    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Months:
            return count
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
}

///
/// A unit representing a number of days
///
public struct Days : CountableType, DayType {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public var days: Int64 {
        return count
    }

    public func supports(field: TemporalUnit) -> Bool {
        switch field {
        case is Days:
            return true
        default:
            return false
        }
    }

    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Days:
            return count
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
}

///
/// A unit representing an hour
///
public struct Hours : CountableType, SecondType {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public var seconds: Int64 {
        return count * 60 * 60

    }

    public func supports(field: TemporalUnit) -> Bool {
        switch field {
        case is Hours:
            return true
        default:
            return false
        }
    }

    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Hours:
            return count
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
}

///
/// A unit representing a minute
///
public struct Minutes : CountableType, SecondType {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public var seconds: Int64 {
        return count * 60
    }

    public func supports(field: TemporalUnit) -> Bool {
        switch field {
        case is Minutes:
            return true
        default:
            return false
        }
    }

    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Minutes:
            return count
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
}

///
/// A unit representing a second
///
public struct Seconds : CountableType, SecondType {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public init(_ amount: SecondType) {
        self.count = amount.seconds
    }

    public var seconds: Int64 {
        return count
    }

    public func supports(field: TemporalUnit) -> Bool {
        switch field {
        case is Seconds:
            return true
        default:
            return false
        }
    }

    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Seconds:
            return count
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
}

///
/// A unit representing nano seconds
///
public struct NanoSeconds : CountableType, NanoSecondType {
    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public init(_ amount: NanoSecondType) {
        self.count = amount.nanoSeconds
    }

    public var nanoSeconds: Int64 {
        return count
    }

    public func supports(field: TemporalUnit) -> Bool {
        switch field {
        case is NanoSeconds:
            return true
        default:
            return false
        }
    }

    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is NanoSeconds:
            return count
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
}
