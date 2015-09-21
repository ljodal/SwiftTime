//
//  ZonedInstant.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 21.09.2015.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public protocol ZonedInstantConvertible {
    /// Get the zoned instant representation of this object
    func toZonedInstant() -> ZonedInstant
}

public struct ZonedInstant : Temporal {
    public var instant: Instant
    public var zone: TimeZone
    private var chronology: Chronology

    public init(instant: Instant, zone: TimeZone) {
        self.instant = instant
        self.zone = zone
        self.chronology = ISOChronology.instance
    }

    public static func now(zone: TimeZone) -> ZonedInstant {
        return ZonedInstant(instant: Instant.now(), zone: zone)
    }

    public func toMillis() -> Int64 {
        return instant.toMillis()
    }
}

extension ZonedInstant : ZonedInstantConvertible {
    /// Get the zoned instant representation of this object
    public func toZonedInstant() -> ZonedInstant {
        return self
    }
}

extension ZonedInstant : DateTimeConvertible {
    /// Get the date time representation of this object
    public func toDateTime() -> DateTime {
        let (year, month, date) = chronology.fromEpoch(instant.seconds.count)
        return try! DateTime(
            year: year, month: month, date: date,
            hours: 0, minutes: 0, seconds: 0, nanos: 0,
            zone: zone)
    }
}