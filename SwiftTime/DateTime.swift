//
//  DateTime.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public struct DateTime : Temporal {

    public var date: LocalDate
    public var time: LocalTime
    public var zone: TimeZone
    
    public init (
        year: Int64 = 0, month: Int8 = 1, date: Int8 = 1,
        hours: Int8 = 0, minutes: Int8 = 0, seconds: Int8 = 0, nanos: Int32 = 0,
        zone: TimeZone = TZ.UTC) throws
    {
        self.date = try LocalDate(year: year, month: month, day: date)
        self.time = try LocalTime(hour: hours, minute: minutes, second: seconds, nanos: nanos)
        self.zone = zone
    }

    public init (date: LocalDate, time: LocalTime, zone: TimeZone = TZ.UTC) {
        self.date = date
        self.time = time
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
        return DateTime(date: date + amount, time: time, zone: zone)
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
    return lhs.date == rhs.date && lhs.time == rhs.time && lhs.zone == rhs.zone
}