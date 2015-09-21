//
//  ISOChronologyTest.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 21.09.2015.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

import XCTest

@testable import SwiftTime

class ISOChronologyTest: XCTestCase {

    func testFromEpoch() {
        let instant: Int64 = 1442868907

        let (year, month, day) = ISOChronology.instance.fromEpoch(instant)

        XCTAssertEqual(2015, year)
        XCTAssertEqual(9, month)
        XCTAssertEqual(21, day)
    }

    func testFromEpochZero() {
        let seconds: Int64 = 0

        let (year, month, day) = ISOChronology.instance.fromEpoch(seconds)

        XCTAssertEqual(1970, year)
        XCTAssertEqual(1, month)
        XCTAssertEqual(1, day)
    }

    func testFromEpochJan2() {
        let seconds: Int64 = 86_400

        let (year, month, day) = ISOChronology.instance.fromEpoch(seconds)

        XCTAssertEqual(1970, year)
        XCTAssertEqual(1, month)
        XCTAssertEqual(2, day)
    }

    func testFromEpochNegativeSeconds1() {
        let seconds: Int64 = -1

        let (year, month, day) = ISOChronology.instance.fromEpoch(seconds)

        XCTAssertEqual(1969, year)
        XCTAssertEqual(12, month)
        XCTAssertEqual(31, day)
    }

    func testFromEpochNegativeSeconds2() {
        let seconds: Int64 = -86_400

        let (year, month, day) = ISOChronology.instance.fromEpoch(seconds)

        XCTAssertEqual(1969, year)
        XCTAssertEqual(12, month)
        XCTAssertEqual(31, day)
    }

    func testFromEpochNegativeSeconds3() {
        let seconds: Int64 = -86_401

        let (year, month, day) = ISOChronology.instance.fromEpoch(seconds)

        XCTAssertEqual(1969, year)
        XCTAssertEqual(12, month)
        XCTAssertEqual(30, day)
    }

    func testToEpoch1() {
        let seconds = ISOChronology.instance.toEpoch(year: 1970, month: 1, day: 1)

        XCTAssertEqual(0, seconds)
    }

    func testToEpoch2() {
        let seconds = ISOChronology.instance.toEpoch(year: 1969, month: 12, day: 31)

        XCTAssertEqual(-86_400, seconds)
    }

    func testToEpoch3() {
        let instant: Int64 = 1442868907 - 1442868907 % 86_400

        let seconds = ISOChronology.instance.toEpoch(year: 2015, month: 9, day: 21)

        XCTAssertEqual(instant, seconds)
    }

    func testLeapYearsBetween1() {
        let c = ISOChronology.instance
        let leaps = c.leapYears(from: 2000, to: 2016)
        XCTAssertEqual(leaps, 4, "Expected 4 leap years, was: \(leaps)")
    }

    func testLeapYearsBetween2() {
        let c = ISOChronology.instance
        let leaps = c.leapYears(from: -2016, to: -2000)
        XCTAssertEqual(leaps, 4, "Expected 4 leap years, was: \(leaps)")
    }

    func testLeapYearsBetween3() {
        let c = ISOChronology.instance
        let leaps = c.leapYears(from: 0, to: 400)
        XCTAssertEqual(leaps, 97, "Expected 97 leap years, was: \(leaps)")
    }

    func testOrdinal1() {
        let c = ISOChronology.instance
        let (y, m, d) = c.ordinalDay(year: 2015, days: 366)

        XCTAssertEqual(y, 2016)
        XCTAssertEqual(m, 1)
        XCTAssertEqual(d, 1)
    }

    func testOrdinal2() {
        let c = ISOChronology.instance
        let (y, m, d) = c.ordinalDay(year: 2015, days: 0)

        XCTAssertEqual(y, 2014)
        XCTAssertEqual(m, 12)
        XCTAssertEqual(d, 31)
    }

    func testOrdinal3() {
        let c = ISOChronology.instance
        let (y, m, d) = c.ordinalDay(year: 2015, days: -1)

        XCTAssertEqual(y, 2014)
        XCTAssertEqual(m, 12)
        XCTAssertEqual(d, 30)
    }

    func testOrdinal4() {
        let c = ISOChronology.instance
        let (y, m, d) = c.ordinalDay(year: 2010, days: 59)

        XCTAssertEqual(y, 2010)
        XCTAssertEqual(m, 2)
        XCTAssertEqual(d, 28)
    }

    func testOrdinal5() {
        let c = ISOChronology.instance
        let (y, m, d) = c.ordinalDay(year: 2010, days: 60)

        XCTAssertEqual(y, 2010)
        XCTAssertEqual(m, 3)
        XCTAssertEqual(d, 1)
    }
}
