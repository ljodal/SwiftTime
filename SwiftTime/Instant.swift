//
//  DateTime.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

private let nanosPerSecond: Int32 = 1_000_000_000
private let millisPerSecond: Int64 = 1_000
private let nanosPerMillis: Int32 = 1_000_000
private let microsPerNano: Int32 = 1_000

public protocol InstantConvertible {
    func toInstant() -> Instant
}

/**
 * A struct that stores the number of nano seconds since
 * Unix Epoch (1970-01-01)
 */
public struct Instant : Temporal, Equatable {
    public var seconds: Int64
    public var nanos: Int32

    public var zone: TimeZone

    internal var chronology: Chronology = ISOChronology.instance

    public init(seconds: Int64 = 0, nanos: Int32 = 0, zone: TimeZone = UTC.instance) {
        self.seconds = seconds
        self.nanos = nanos
        self.zone = zone
        Instant.normalize(&self)
    }
    
    public init(millis: Int64, zone: TimeZone = UTC.instance) {
        self.seconds = millis / millisPerSecond
        self.nanos = Int32(millis % millisPerSecond) * nanosPerMillis
        self.zone = zone
    }

    //
    // MARK: Static initializers
    //

    ///
    /// Get an instant that represents time right now
    ///
    public static func now(zone: TimeZone = UTC.instance) -> Instant {

        var tv: timeval = timeval.init()
        gettimeofday(&tv, nil)

        let seconds = Int64(tv.tv_sec)
        let nanos = Int32(tv.tv_usec) * microsPerNano

        return Instant(seconds: seconds, nanos: nanos, zone: zone)
    }

    //
    // MARK: Get
    //

    public func toMillis() -> Int64 {
        return (seconds * 1_000) + Int64(nanos / nanosPerSecond)
    }

    //
    // Convert
    //

    /// Helper method to fix too many nano seconds
    private static func normalize(inout instant: Instant) {

        if instant.nanos > nanosPerSecond {
            let seconds = instant.nanos / nanosPerSecond
            instant.seconds += Int64(seconds)
            instant.nanos -= seconds * nanosPerSecond
        } else if instant.nanos < 0 {
            let seconds = instant.nanos / nanosPerSecond
            instant.seconds += Int64(seconds)
            instant.nanos -= seconds * nanosPerSecond
        }
    }
}

extension Instant : DateTimeConvertible {
    /// Get the date time representation of this object
    public func toDateTime() -> DateTime {

        let offset = zone.offsetAt(self).count
        let time = self.seconds + offset

        let (year, month, date) = chronology.fromEpoch(time)
        let secondsOfDay = time % 86_400
        let hour = Int8(secondsOfDay / 3_600)
        let minute = Int8((secondsOfDay % 3_600) / 60)
        let seconds = Int8(secondsOfDay % 60)

        return DateTime(
            year, month, date,
            hour, minute, seconds, Int32(nanos),
            Int32(offset), zone
        )
    }
}

extension Instant : InstantConvertible {
    public func toInstant() -> Instant {
        return self
    }
}

public func == (lhs: Instant, rhs: Instant) -> Bool {
    return lhs.seconds == rhs.seconds && lhs.nanos == rhs.nanos
}

public func + (lhs: Instant, rhs: TemporalAmount) -> Instant {

    let (m, d, s, n) = rhs.components()

    if m == 0 && d == 0 {
        return Instant(seconds: lhs.seconds + s, nanos: lhs.nanos + n)
    } else {
        fatalError("Not implemented")
    }
}

public func - (lhs: Instant, rhs: TemporalAmount) -> Instant {
    fatalError("Not implemented")
}

public func - <T : Temporal> (lhs: Instant, rhs: T) -> TemporalAmount {
    fatalError("Not implemented")
}