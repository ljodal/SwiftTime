//
//  Duration.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

/**
An amount of time
*/
public protocol TemporalAmount {
    func supports(field: TemporalUnit) -> Bool
    func get(unit: TemporalUnit) throws -> Int64
}

public protocol TemporalAmountMath : TemporalAmount {
    func add(other: Self) -> Self
    func subtract(other: Self) -> Self
    func multiply(factor: Int) -> Self
    func divide(divider: Int) -> Self
    func +=(inout lhs: Self, rhs: Self)
    func -=(inout lhs: Self, rhs: Self)
    func /=(inout lhs: Self, divider: Int)
    func *=(inout rhs: Self, factor: Int)
}

func +<T : TemporalAmountMath>(lhs: T, rhs: T) -> T {
    return lhs.add(rhs)
}

func -<T : TemporalAmountMath>(lhs: T, rhs: T) -> T {
    return lhs.subtract(rhs)
}

func *<T : TemporalAmountMath>(lhs: T, rhs: Int) -> T {
    return lhs.multiply(rhs)
}

func /<T : TemporalAmountMath>(lhs: T, rhs: Int) -> T {
    return lhs.divide(rhs)
}



/**
An amount of time in seconds and nano seconds
*/
public struct Duration : TemporalAmount {
    public let seconds: Int64
    public let nanoSeconds: Int32

    public init(seconds: Int64, nanoSeconds: Int32) {
        self.seconds = seconds
        self.nanoSeconds = nanoSeconds
    }

    public init() {
        self.seconds = 0
        self.nanoSeconds = 0
    }

    public func supports(field: TemporalUnit) -> Bool {
        return false
    }

    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Seconds:
            return seconds
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }

    public func add(other: Duration) -> Duration {
        return Duration(seconds: self.seconds + other.seconds,
            nanoSeconds: self.nanoSeconds + other.nanoSeconds)
    }

    public func add<T : SecondsRepresentableAmount>(s: T) -> Duration {
        return Duration(seconds: self.seconds + s.seconds, nanoSeconds: self.nanoSeconds)
    }
}

/**
An amount of time in years, months, and days.
*/
public struct Period : TemporalAmount {
    public let years: Int64
    public let months: Int64
    public let days: Int64
    public let duration: Duration

    public init(years: Int64, months: Int64, days: Int64) {
        self.years = years
        self.months = months
        self.days = days
        self.duration = Duration()
    }

    public init(amounts: TemporalAmount...) throws {

        var duration = Duration()

        for amount in amounts {
            switch amount {
            case let h as Hours:
                duration = duration.add(h)
            case let m as Minutes:
                duration = duration.add(m)
            case let s as Seconds:
                duration = duration.add(s)
            case let d as Duration:
                duration = duration.add(d)
            default:
                throw DateTimeErrors.UnsupportedAmount
            }
        }

        self.years = 0
        self.months = 0
        self.days = 0
        self.duration = duration
    }

    public func supports(unit: TemporalUnit) -> Bool {
        return false
    }

    public func get(field: TemporalUnit) throws -> Int64 {
        throw DateTimeErrors.UnsupportedUnit
    }
}