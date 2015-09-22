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
public struct Instant : Temporal, TemporalMath {
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
    // MARK: Add
    //

    public func add(amount: Duration) -> Instant {
        var new = self
        new.seconds += amount.seconds.count
        new.nanos += Int32(amount.nanoSeconds.count)
        Instant.normalize(&new)
        return new
    }

    // TODO: Implement
    public func add(amount: Period) -> Instant {
        fatalError("Method not implemented yet")
    }

    public func add<T : NanoSecondType>(amount: T) -> Instant {
        var new = self
        new.nanos += Int32(amount.nanoSeconds.nanoSeconds.count)
        Instant.normalize(&new)
        return new
    }

    public func add<T : SecondType>(amount: T) -> Instant {
        var new = self
        new.seconds += amount.seconds.seconds.count
        return new
    }

    //
    // MARK: Subtract
    //

    public func subtract(amount: Duration) -> Instant {
        var new = self
        new.seconds -= amount.seconds.seconds
        new.nanos -= Int32(amount.nanoSeconds.nanoSeconds)
        Instant.normalize(&new)
        return new
    }

    // TODO: Implement
    public func subtract(amount: Period) -> Instant {
        fatalError("Method not implemented yet")
    }

    public func subtract<T : NanoSecondType>(amount: T) -> Instant {
        var new = self
        new.nanos -= Int32(amount.nanoSeconds)
        Instant.normalize(&new)
        return new
    }

    public func subtract<T : SecondType>(amount: T) -> Instant {
        var new = self
        new.seconds -= amount.seconds
        return new
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


public func == (lhs: Instant, rhs: Instant) -> Bool {
    return lhs.seconds == rhs.seconds && lhs.nanos == rhs.nanos
}