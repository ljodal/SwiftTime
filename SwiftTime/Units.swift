//
//  Units.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

///
/// A temporal amount representing a given number of years
///
public struct Years : TemporalAmount, CountableType, Equatable {
    public var count: Int64

    public var months: Int64 {
        return count * 12
    }

    public var days: Int64 {
        return 0
    }

    public var seconds: Int64 {
        return 0
    }

    public var nanoSeconds: Int32 {
        return 0
    }

    public func components() -> (Int64, Int64, Int64, Int32) {
        return (count * 12, 0, 0, 0)
    }

    public init(_ count: Int64) {
        self.count = count
    }
}

///
/// A temporal amount representing a given number of months
///
public struct Months : TemporalAmount, CountableType, Equatable {
    public var count: Int64

    public var months: Int64 {
        return count
    }

    public var days: Int64 {
        return 0
    }

    public var seconds: Int64 {
        return 0
    }

    public var nanoSeconds: Int32 {
        return 0
    }

    public func components() -> (Int64, Int64, Int64, Int32) {
        return (count, 0, 0, 0)
    }

    public init(_ count: Int64) {
        self.count = count
    }
}

///
/// A temporal amount representing a given number of days
///
public struct Days : TemporalAmount, CountableType, Equatable {
    public var count: Int64

    public var months: Int64 {
        return 0
    }

    public var days: Int64 {
        return count
    }

    public var seconds: Int64 {
        return 0
    }

    public var nanoSeconds: Int32 {
        return 0
    }

    public func components() -> (Int64, Int64, Int64, Int32) {
        return (0, count, 0, 0)
    }

    public init(_ count: Int64) {
        self.count = count
    }
}

///
/// A temporal amount representing a given number of hours
///
public struct Hours : TemporalAmount, CountableType, Equatable {
    public var count: Int64

    public var months: Int64 {
        return 0
    }

    public var days: Int64 {
        return 0
    }

    public var seconds: Int64 {
        return count * 3600
    }

    public var nanoSeconds: Int32 {
        return 0
    }

    public func components() -> (Int64, Int64, Int64, Int32) {
        return (0, 0, count * 3600, 0)
    }

    public init(_ count: Int64) {
        self.count = count
    }
}

///
/// A temporal amount representing a given number of minutes
///
public struct Minutes : TemporalAmount, CountableType, Equatable {
    public var count: Int64

    public var months: Int64 {
        return 0
    }

    public var days: Int64 {
        return 0
    }

    public var seconds: Int64 {
        return count * 60
    }

    public var nanoSeconds: Int32 {
        return 0
    }

    public func components() -> (Int64, Int64, Int64, Int32) {
        return (0, 0, count * 60, 0)
    }

    public init(_ count: Int64) {
        self.count = count
    }
}


///
/// A temporal amount representing a given number of seconds
///
public struct Seconds : TemporalAmount, CountableType, Equatable {
    public var count: Int64

    public var months: Int64 {
        return 0
    }

    public var days: Int64 {
        return 0
    }

    public var seconds: Int64 {
        return count
    }

    public var nanoSeconds: Int32 {
        return 0
    }

    public func components() -> (Int64, Int64, Int64, Int32) {
        return (0, 0, count, 0)
    }

    public init(_ count: Int64) {
        self.count = count
    }
}

///
/// A temporal amount representing a given number of seconds
///
public struct NanoSeconds : TemporalAmount, CountableType, Equatable {
    public var count: Int64

    public var months: Int64 {
        return 0
    }

    public var days: Int64 {
        return 0
    }

    public var seconds: Int64 {
        return count / Int64(NANOS_PER_SECONDS)
    }

    public var nanoSeconds: Int32 {
        return Int32(count % Int64(NANOS_PER_SECONDS))
    }

    public func components() -> (Int64, Int64, Int64, Int32) {
        return (0, 0, seconds, nanoSeconds)
    }

    public init(_ count: Int64) {
        self.count = count
    }
}