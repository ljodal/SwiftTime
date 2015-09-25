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

/**
 * A struct that stores the number of nano seconds since
 * Unix Epoch (1970-01-01)
 */
public struct Instant : Temporal {
    public var seconds: Int64
    public var nanos: Int32
    
    public init(seconds: Int64) {
        self.seconds = seconds
        self.nanos = 0
    }
    
    public init(seconds: Int64, nanos: Int32) {
        self.seconds = seconds
        self.nanos = nanos
        Instant.normalize(&self)
    }
    
    public init(millis: Int64) {
        self.seconds = millis / millisPerSecond
        self.nanos = Int32(millis % millisPerSecond) * nanosPerMillis
    }

    //
    // MARK: Static initializers
    //

    ///
    /// Get an instant that represents time right now
    ///
    public static func now() -> Instant {

        var tv: timeval = timeval.init()
        gettimeofday(&tv, nil)

        let seconds = Int64(tv.tv_sec)
        let nanos = Int32(tv.tv_usec) * microsPerNano

        return Instant(seconds: seconds, nanos: nanos)
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

    /// Convert to a `DateTime`
    public func inZone(zone: TimeZone) -> DateTime {
        //let daysSinceEpoch = self.seconds / 84_600
        //let secondsInDay = self.seconds % 64_600

        fatalError("Method not implemented yet")
    }

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

extension Instant : Equatable {
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