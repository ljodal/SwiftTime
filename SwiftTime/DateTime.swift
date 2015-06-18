//
//  DateTime.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public struct DateTime : Temporal {
    let year: Int64
    let month: Int64
    let date: Int64
    let hours: Int64
    let minutes: Int64
    let seconds: Int64
    let nanos: Int64
    let zone: TimeZone
    
    public init(
        year: Int64 = 0,
        month: Int64 = 1,
        date: Int64 = 1,
        hours: Int64 = 0,
        minutes: Int64 = 0,
        seconds: Int64 = 0,
        nanos: Int64 = 0,
        zone: TimeZone = TZ.UTC)
    {
        self.year = year
        self.month = month
        self.date = date
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.nanos = nanos
        self.zone = zone
    }

    public func add<T : NanoSecondsRepresentableAmount>(amount: T) -> DateTime {
        // TODO: Implement
        abort()
    }

    public func add<T : SecondsRepresentableAmount>(amount: T) -> DateTime {
        // TODO: Implement
        abort()
    }

    public func add(amount: Duration) -> DateTime {
        // TODO: Implement
        abort()
    }

    public func add(amount: Period) -> DateTime {
        // TODO: Implement
        abort()
    }

    public func subtract<T : NanoSecondsRepresentableAmount>(amount: T) -> DateTime {
        // TODO: Implement
        abort()
    }

    public func subtract<T : SecondsRepresentableAmount>(amount: T) -> DateTime {
        // TODO: Implement
        abort()
    }

    public func subtract(amount: Duration) -> DateTime {
        // TODO: Implement
        abort()
    }

    public func subtract(amount: Period) -> DateTime {
        // TODO: Implement
        abort()
    }
}

public func == (lhs: DateTime, rhs: DateTime) -> Bool {
    return lhs.year == rhs.year &&
        lhs.month == rhs.month &&
        lhs.date == rhs.date &&
        lhs.hours == rhs.hours &&
        lhs.seconds == rhs.seconds &&
        lhs.nanos == rhs.nanos
}