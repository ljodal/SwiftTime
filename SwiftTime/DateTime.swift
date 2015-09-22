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

public struct DateTime : Temporal {

    public var date: LocalDate
    public var time: LocalTime
    public var zone: TimeZone

    //
    // Mark: Initializers
    //
    
    public init (
        year: Int64 = 0, month: Int8 = 1, date: Int8 = 1,
        hours: Int8 = 0, minutes: Int8 = 0, seconds: Int8 = 0, nanos: Int32 = 0,
        zone: TimeZone = UTC.instance) throws
    {
        self.date = try LocalDate(year: year, month: month, day: date)
        self.time = try LocalTime(hour: hours, minute: minutes, second: seconds, nanos: nanos)
        self.zone = zone
    }

    public init (date: LocalDate, time: LocalTime, zone: TimeZone = UTC.instance) {
        self.date = date
        self.time = time
        self.zone = zone
    }

    //
    // Mark: Get
    //

    public func toMillis() -> Int64 {
        return date.toUnixTime()
    }
}

extension DateTime : DateTimeConvertible {
    public func toDateTime() -> DateTime {
        return self
    }
}

extension DateTime : TemporalMath {

    //
    // MARK: Arithmic
    //

    public func add<T : NanoSecondType>(amount: T) -> DateTime {
        // TODO: Implement
        fatalError("Method not implemented")
    }

    public func add<T : SecondType>(amount: T) -> DateTime {
        // TODO: Implement
        fatalError("Method not implemented")
    }

    public func add(amount: Duration) -> DateTime {
        // TODO: Implement
        fatalError("Method not implemented")
    }

    public func add(amount: Period) -> DateTime {
        return DateTime(date: date + amount, time: time, zone: zone)
    }

    public func subtract<T : NanoSecondType>(amount: T) -> DateTime {
        // TODO: Implement
        fatalError("Method not implemented")
    }

    public func subtract<T : SecondType>(amount: T) -> DateTime {
        // TODO: Implement
        fatalError("Method not implemented")
    }

    public func subtract(amount: Duration) -> DateTime {
        // TODO: Implement
        fatalError("Method not implemented")
    }

    public func subtract(amount: Period) -> DateTime {
        // TODO: Implement
        fatalError("Method not implemented")
    }
}

public func == (lhs: DateTime, rhs: DateTime) -> Bool {
    return lhs.date == rhs.date && lhs.time == rhs.time && lhs.zone == rhs.zone
}

extension DateTime : CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(date.debugDescription)T\(time.debugDescription)";
    }
}