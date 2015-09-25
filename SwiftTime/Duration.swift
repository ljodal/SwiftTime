//
//  Duration.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 25.09.2015.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

///
/// An amount of time
///
public struct Duration : TemporalAmount {

    public var months: Int64
    public var days: Int64
    public var seconds: Int64
    public var nanoSeconds: Int32

    ///
    /// Public constructor that validates and normalizes
    /// all components.
    ///
    public init (months: Int64 = 0, days: Int64 = 0,
        var seconds: Int64 = 0, var nanoSeconds: Int32 = 0)
    {
        // Normalize nanoSeconds component
        if abs(nanoSeconds) >= NANOS_PER_SECONDS {
            seconds += Int64(nanoSeconds / NANOS_PER_SECONDS)
            nanoSeconds = nanoSeconds % NANOS_PER_SECONDS
        }

        self.months = months
        self.days = days
        self.seconds = seconds
        self.nanoSeconds = nanoSeconds
    }

    ///
    /// Non-validating internal constructor
    ///
    internal init (_ months: Int64, _ days: Int64, _ seconds: Int64, _ nanos: Int32) {
        self.months = months
        self.days = days
        self.seconds = seconds
        self.nanoSeconds = nanos
    }

    ///
    /// Get all components of this duration in a single call
    ///
    public func components() -> (Int64, Int64, Int64, Int32) {
        return (months, days, seconds, nanoSeconds)
    }
}