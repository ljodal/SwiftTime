//
//  DateTime.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

/**
 * A struct that stores the number of nano seconds since
 * Unix Epoch (1970-01-01)
 */
public struct Instant : Temporal, TemporalMath {
    public var seconds: Seconds
    public var nanos: NanoSeconds
    
    public init(seconds: Int64) {
        self.seconds = seconds.seconds
        self.nanos = 0.nanoSeconds
    }
    
    public init(seconds: Int64, nanos: Int32) {
        self.seconds = seconds.seconds
        self.nanos = nanos.nanoSeconds
        Instant.normalize(&self)
    }
    
    public init(millis: Int64) {
        self.seconds = (millis / 1_000).seconds
        self.nanos = ((millis % 1_000) * 1_000_000).nanoSeconds
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
        let nanos = Int32(tv.tv_usec * 1000)
        return Instant(seconds: seconds, nanos: nanos)
    }

    //
    // MARK: Get
    //

    public func toMillis() -> Int64 {
        return (seconds.count * 1_000) + (nanos.count / 1_000_000)
    }

    //
    // MARK: Add
    //

    public func add(amount: Duration) -> Instant {
        var new = self
        new.seconds += amount.seconds
        new.nanos += amount.nanoSeconds
        Instant.normalize(&new)
        return new
    }

    // TODO: Implement
    public func add(amount: Period) -> Instant {
        fatalError("Method not implemented yet")
    }

    public func add<T : NanoSecondType>(amount: T) -> Instant {
        var new = self
        new.nanos += NanoSeconds(amount)
        Instant.normalize(&new)
        return new
    }

    public func add<T : SecondType>(amount: T) -> Instant {
        var new = self
        new.seconds += Seconds(amount)
        return new
    }

    //
    // MARK: Subtract
    //

    public func subtract(amount: Duration) -> Instant {
        var new = self
        new.seconds -= amount.seconds
        new.nanos -= amount.nanoSeconds
        Instant.normalize(&new)
        return new
    }

    // TODO: Implement
    public func subtract(amount: Period) -> Instant {
        fatalError("Method not implemented yet")
    }

    public func subtract<T : NanoSecondType>(amount: T) -> Instant {
        var new = self
        new.nanos -= NanoSeconds(amount)
        Instant.normalize(&new)
        return new
    }

    public func subtract<T : SecondType>(amount: T) -> Instant {
        var new = self
        new.seconds -= Seconds(amount)
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

        if instant.nanos.nanoSeconds > 1_000_000 {
            let seconds = Int64(instant.nanos.nanoSeconds) / 1_000_000
            instant.seconds += seconds.seconds
        } else if instant.nanos.nanoSeconds < 0 {
            let seconds = instant.nanos.nanoSeconds / 1_000_000
            instant.seconds += seconds.seconds
            instant.nanos -= (seconds * 1_000_000).nanoSeconds
        }
    }
}


public func == (lhs: Instant, rhs: Instant) -> Bool {
    return lhs.seconds == rhs.seconds && lhs.nanos == rhs.nanos
}