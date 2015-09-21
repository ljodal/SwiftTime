//
//  ZonedInstant.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 21.09.2015.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

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

    public func year() {
    }
}