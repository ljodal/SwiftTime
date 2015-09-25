//
//  DateTime.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public protocol DateTimeConvertible {

    /// Get the date time representation of this object
    func toDateTime() -> DateTime
}

public struct DateTime : Temporal, Equatable {

    //
    // MARK: Instance variables
    //

    public var year: Int64
    public var month: Int8
    public var day: Int8

    public var hours: Int8
    public var minutes: Int8
    public var seconds: Int8
    public var nanoSeconds: Int32

    public var offset: Int32

    public var zone: TimeZone

    internal let chronology: Chronology

    //
    // MARK: Initializers
    //
    
    public init (
        year: Int64 = 0, month: Int8 = 1, day: Int8 = 1,
        hours: Int8 = 0, minutes: Int8 = 0, seconds: Int8 = 0, nanoSeconds: Int32 = 0,
        zone: TimeZone = UTC.instance) throws
    {
        self.chronology = ISOChronology.instance

        // Validate that the input arguments are valid
        try self.chronology.validate(year, month, day, hours, minutes, seconds, nanoSeconds)

        self.year = year
        self.month = month
        self.day = day

        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.nanoSeconds = nanoSeconds

        self.offset = 0 // TODO: Calculate actual offset

        self.zone = zone
    }

    /// Internal non-validating initializer
    internal init(
        _ year: Int64 = 0, _ month: Int8 = 1, _ day: Int8 = 1,
        _ hours: Int8 = 0, _ minutes: Int8 = 0, _ seconds: Int8 = 0, _ nanos: Int32 = 0,
        _ offset: Int32, _ zone: TimeZone = UTC.instance)
    {
        self.chronology = ISOChronology.instance

        self.year = year
        self.month = month
        self.day = day

        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.nanoSeconds = nanos

        self.offset = offset
        
        self.zone = zone
    }

    //
    // Mark: Get
    //

    public func toMillis() -> Int64 {
        var seconds: Int64 = 0
        seconds += chronology.toEpoch(year: year, month: month, day: day)
        seconds += Int64(hours) * 3600
        seconds += Int64(minutes) * 60
        seconds += Int64(seconds)

        return seconds * 1000 + Int64(nanoSeconds) / 1000 - Int64(offset)
    }
}

extension DateTime : DateTimeConvertible {
    public func toDateTime() -> DateTime {
        return self
    }
}

public func == (lhs: DateTime, rhs: DateTime) -> Bool {
    return (
        lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day &&
        lhs.hours == rhs.hours && lhs.minutes == rhs.minutes && lhs.seconds == rhs.seconds &&
        lhs.nanoSeconds == rhs.nanoSeconds && lhs.offset == rhs.offset
    )
}

extension DateTime : CustomDebugStringConvertible {
    public var debugDescription: String {
        return String(format: "%04d-%02d-%02dT%02d:%02d:%02d.%09d",
            year, month, day, hours, minutes, seconds, nanoSeconds)
    }
}


public func + <T : Temporal> (lhs: DateTime, rhs: TemporalAmount) -> T {
    fatalError("Not implemented")
}

public func - <T : Temporal> (lhs: DateTime, rhs: TemporalAmount) -> T {
    fatalError("Not implemented")
}

public func - <T : Temporal> (lhs: DateTime, rhs: T) -> TemporalAmount {
    fatalError("Not implemented")
}
