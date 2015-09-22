//
//  ZonedInstantTests.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 22.09.2015.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

import XCTest

@testable import SwiftTime

class ZonedInstantTests: XCTestCase {

    func testExample() {
        let i = ZonedInstant.now(UTC.instance)

        let d = i.toDateTime()

        print(d)
    }

    func testToDateTimeUTC() {
        let z = UTC.instance
        let i = ZonedInstant(instant: Instant(seconds: 1442948012), zone: z)

        let d = i.toDateTime()

        print(d)
    }

    func testToDateTimeCET() {
        let z = PrecalculatedZone.CET
        let i = ZonedInstant(instant: Instant(seconds: 1442948012), zone: z)

        let d = i.toDateTime()

        print(d)
    }

    func testtoDateBeforeDST() {
        let z = PrecalculatedZone.CET
        let i = ZonedInstant(instant: Instant(seconds: 1427587200), zone: z)

        let d = i.toDateTime()

        XCTAssertEqual(2015, d.date.year)
        XCTAssertEqual(3, d.date.month)
        XCTAssertEqual(29, d.date.day)

        XCTAssertEqual(1, d.time.hour)
        XCTAssertEqual(0, d.time.minute)
        XCTAssertEqual(0, d.time.second)
        XCTAssertEqual(0, d.time.nanos)
    }

    func testtoDateAfterDST() {
        let z = PrecalculatedZone.CET
        let i = ZonedInstant(instant: Instant(seconds: 1427590800), zone: z)

        let d = i.toDateTime()

        XCTAssertEqual(2015, d.date.year)
        XCTAssertEqual(3, d.date.month)
        XCTAssertEqual(29, d.date.day)

        XCTAssertEqual(3, d.time.hour)
        XCTAssertEqual(0, d.time.minute)
        XCTAssertEqual(0, d.time.second)
        XCTAssertEqual(0, d.time.nanos)
    }
}
