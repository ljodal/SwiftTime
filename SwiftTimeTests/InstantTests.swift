//
//  InstantTests.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 21.09.2015.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

import XCTest

@testable import SwiftTime

class InstantTests: XCTestCase {

    func testNow() {
        let i = Instant.now(UTC.instance)

        let d = i.toDateTime()

        print(d)
    }

    func testAdd() {
        var time = Instant.now()

        self.measureBlock {
            for _ in 0..<10_000_000 {
                time = time + 1.seconds
            }
        }

        print(time)
    }

    func testToDateTimeUTC() {
        let z = UTC.instance
        let i = Instant(seconds: 1442948012, zone: z)

        let d = i.toDateTime()

        print(d)
    }

    func testToDateTimeCET() {
        let z = PrecalculatedZone.CET
        let i = Instant(seconds: 1442948012, zone: z)

        let d = i.toDateTime()

        print(d)
    }

    func testToDateBeforeDST() {
        let z = PrecalculatedZone.CET
        let i = Instant(seconds: 1427587200, zone: z)

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
        let i = Instant(seconds: 1427590800, zone: z)

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