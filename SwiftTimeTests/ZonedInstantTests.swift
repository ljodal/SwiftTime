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

    func testNow() {
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

    func testToDateBeforeDST() {
        let z = PrecalculatedZone.CET
        let i = ZonedInstant(instant: Instant(seconds: 1427587200), zone: z)

        let d = i.toDateTime()

        XCTAssertEqual(2015, d.year)
        XCTAssertEqual(3, d.month)
        XCTAssertEqual(29, d.day)

        XCTAssertEqual(1, d.hours)
        XCTAssertEqual(0, d.minutes)
        XCTAssertEqual(0, d.seconds)
        XCTAssertEqual(0, d.nanoSeconds)
    }

    func testToDateAfterDST() {
        let z = PrecalculatedZone.CET
        let i = ZonedInstant(instant: Instant(seconds: 1427590800), zone: z)

        let d = i.toDateTime()

        XCTAssertEqual(2015, d.year)
        XCTAssertEqual(3, d.month)
        XCTAssertEqual(29, d.day)

        XCTAssertEqual(3, d.hours)
        XCTAssertEqual(0, d.minutes)
        XCTAssertEqual(0, d.seconds)
        XCTAssertEqual(0, d.nanoSeconds)
    }
}
