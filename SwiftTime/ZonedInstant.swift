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

        let offset = zone.offsetAt(instant).count
        let time = instant.seconds + offset

        let (year, month, date) = chronology.fromEpoch(time)
        let secondsOfDay = time % 86_400
        let hour = Int8(secondsOfDay / 3_600)
        let minute = Int8((secondsOfDay % 3_600) / 60)
        let seconds = Int8(secondsOfDay % 60)

        return DateTime(
            year, month, date,
            hour, minute, seconds, Int32(instant.nanos),
            Int32(offset), zone
        )
    }
}