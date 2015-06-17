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
    Add `amount` of this unit to the given temporal
    */
    static func addTo<T : Temporal>(temporal: T, amount: Int64) throws -> T
    
    /**
    Get the number of this unit between the two temporals
    */
    static func between<T : Temporal>(start: T, and: T) -> Int64
}

///
/// A protocol for time deltas that are represented by a count of a single unit.
/// E.g. 5 hours or 10 minutes
///
public protocol CountableAmount : TemporalAmountMath, Equatable {
    /// The count that this time delta contains
    var count: Int64 { get set }

    /// Initialized that sets the count
    init(_ count: Int64)
}

public func ==<T : CountableAmount>(lhs: T, rhs: T) -> Bool {
    return lhs.count == rhs.count
}

public func +<T : CountableAmount>(lhs: T, rhs: T) -> T {
    return lhs.add(rhs)
}

public func +<T : CountableAmount>(lhs: Int, rhs: T) -> T {
    return rhs.add(T(Int64(lhs)))
}

public func +<T : CountableAmount>(lhs: T, rhs: Int) -> T {
    return lhs.add(T(Int64(rhs)))
}

public func -<T : CountableAmount>(lhs: T, rhs: T) -> T {
    return lhs.subtract(rhs)
}

public func -<T : CountableAmount>(lhs: Int, rhs: T) -> T {
    return rhs.subtract(T(Int64(lhs)))
}

public func -<T : CountableAmount>(lhs: T, rhs: Int) -> T {
    return lhs.subtract(T(Int64(rhs)))
}

public func *<T : CountableAmount>(lhs: T, rhs: Int) -> T {
    return lhs.multiply(rhs)
}

public func /<T : CountableAmount>(lhs: T, rhs: Int) -> T {
    return lhs.divide(rhs)
}

public func +=<T : CountableAmount>(inout lhs: T, rhs: T) {
    lhs.count += rhs.count
}

public func -=<T : CountableAmount>(inout lhs: T, rhs: T) {
    lhs.count -= rhs.count
}

public func /=<T : CountableAmount>(inout lhs: T, divider: Int) {
    lhs.count /= Int64(divider)
}

public func *=<T : CountableAmount>(inout lhs: T, factor: Int) {
    lhs.count *= Int64(factor)
}

public extension CountableAmount {
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
/// A protocol for time amounts that can be representated as a number of seconds
///
public protocol SecondsRepresentableAmount : CountableAmount {
    var seconds: Int64 { get }
}

///
/// A protocol for time amounts that can be representated as a number of nano seconds
///
public protocol NanoSecondsRepresentableAmount : CountableAmount {
    var nanoSeconds: Int64 { get }
}

/**
A unit representing an hour
*/
public struct Hours : SecondsRepresentableAmount {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public var seconds: Int64 {
        get {
            return count * 60 * 60
        }
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

    public func add(other: TemporalAmount) -> TemporalAmount {
        return self
    }

    public func subtract(other: TemporalAmount) -> TemporalAmount {
        return self
    }
}

/**
A unit representing a minute
*/
public struct Minutes : SecondsRepresentableAmount {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public var seconds: Int64 {
        get {
            return count * 60
        }
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

    public func add(other: TemporalAmount) -> TemporalAmount {
        return self
    }

    public func subtract(other: TemporalAmount) -> TemporalAmount {
        return self
    }
}

/**
A unit representing a second
*/
public struct Seconds : SecondsRepresentableAmount {

    public var count: Int64

    public init(_ count: Int64) {
        self.count = count
    }

    public var seconds: Int64 {
        get {
            return count
        }
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

    public func add(other: TemporalAmount) -> TemporalAmount {
        return self
    }

    public func subtract(other: TemporalAmount) -> TemporalAmount {
        return self
    }
}
