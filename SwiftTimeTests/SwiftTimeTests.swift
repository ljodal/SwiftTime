//
//  SwiftTimeTests.swift
//  SwiftTimeTests
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

import XCTest

@testable import SwiftTime

class SwiftTimeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPlusSecondsOperator() {
        let d1 = Instant(seconds: 123)
        let d2 = d1 + 123.seconds
        
        XCTAssertEqual(d2.seconds.count, 246)
        XCTAssertEqual(d2.nanos.count, 0)
    }
    
    func testEquals() {
        let d1 = Instant(seconds: 123)
        let d2 = Instant(seconds: 123)
        
        XCTAssertEqual(d1, d2)
    }
    
    func testNotEquals() {
        let d1 = Instant(seconds: 123)
        let d2 = Instant(seconds: 234)
        
        XCTAssertNotEqual(d1, d2)
    }

    func testAdd() {
        var h1 = 1.hours
        h1 += 2.hours

        XCTAssertEqual(h1, 3.hours)
        XCTAssertNotEqual(h1, 1.hours)
    }

    func testAdd2() {
        let h1 = 1.hours + 30.minutes

        XCTAssertEqual(h1, 5400.seconds)
        XCTAssertNotEqual(h1, 5432.seconds)
    }

    func testLocalDate1() {
        let d1 = try! LocalDate(year: 2015, month: 1, day: 31)
        let d2 = d1 + 1.months
        let d3 = try! LocalDate(year: 2015, month: 2, day: 28)

        XCTAssertEqual(d2, d3)
    }

    func testLocalDate2() {
        let d1 = try! LocalDate(year: 2015, month: 12, day: 31)
        let d2 = d1 + 0.months
        let d3 = try! LocalDate(year: 2015, month: 12, day: 31)

        XCTAssertEqual(d2, d3)
    }

    func testLocalDate3() {
        do {
            let d1 = try LocalDate(year: 2015, month: 1, day: 1)
            let d2 = d1 + (-1).months
            let d3 = try LocalDate(year: 2014, month: 12, day: 1)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testLocalDate4() {
        do {
            let d1 = try LocalDate(year: 2015, month: 1, day: 1)
            let d2 = d1 + (-12).months
            let d3 = try LocalDate(year: 2014, month: 1, day: 1)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testLocalDate5() {
        do {
            let d1 = try LocalDate(year: 2015, month: 1, day: 1)
            let d2 = d1 + (-10).months
            let d3 = try LocalDate(year: 2014, month: 3, day: 1)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testLocalDateAddYear1() {
        do {
            let d1 = try LocalDate(year: 2015, month: 1, day: 1)
            let d2 = d1 + 1.years
            let d3 = try LocalDate(year: 2016, month: 1, day: 1)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testLocalDateAddYear2() {
        do {
            let d1 = try LocalDate(year: 2004, month: 2, day: 29)
            let d2 = d1 + 1.years
            let d3 = try LocalDate(year: 2005, month: 2, day: 28)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testLocalDateAddYear3() {
        do {
            let d1 = try LocalDate(year: 2000, month: 2, day: 28)
            let d2 = d1 + 10.years
            let d3 = try LocalDate(year: 2010, month: 2, day: 28)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testAdd1Days() {
        do {
            let d1 = try LocalDate(year: 2010, month: 2, day: 28)
            let d2 = d1 + 1.days
            let d3 = try LocalDate(year: 2010, month: 3, day: 1)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testAdd10Days() {
        do {
            let d1 = try LocalDate(year: 2000, month: 2, day: 25)
            let d2 = d1 + 10.days
            let d3 = try LocalDate(year: 2000, month: 3, day: 6)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testAdd100Days() {
        do {
            let d1 = try LocalDate(year: 2010, month: 1, day: 1)
            let d2 = d1 + 1000.days
            let d3 = try LocalDate(year: 2012, month: 9, day: 27)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testAdd4YearsInDays() {
        do {
            let d1 = try LocalDate(year: 1896, month: 2, day: 29)
            let d2 = d1 + 1461.days
            let d3 = try LocalDate(year: 1900, month: 3, day: 1)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testAdd1000Days() {
        do {
            let d1 = try LocalDate(year: 2010, month: 1, day: 1)
            let d2 = d1 + 100.days
            let d3 = try LocalDate(year: 2010, month: 4, day: 11)

            XCTAssertEqual(d2, d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testOrdinalDate1() {
        do {
            let d1 = try LocalDate(year: 2000, dayOfYear: 28)
            let d2 = try LocalDate(year: 2000, month: 1, day: 28)

            XCTAssertEqual(d1, d2)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testOrdinalDate2() {
        do {
            let d1 = try LocalDate(year: 2000, dayOfYear: 32)
            let d2 = try LocalDate(year: 2000, month: 2, day: 1)

            XCTAssertEqual(d1, d2)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testOrdinalDate3() {
        do {
            let d1 = try LocalDate(year: 2000, dayOfYear: 336)
            let d2 = try LocalDate(year: 2000, month: 12, day: 1)

            XCTAssertEqual(d1, d2)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testLeapYearsBetween1() {
        let c = ISOChronology()
        let leaps = c.leapYears(from: 2000, to: 2016)
        XCTAssertEqual(leaps, 4, "Expected 4 leap years, was: \(leaps)")
    }

    func testLeapYearsBetween2() {
        let c = ISOChronology()
        let leaps = c.leapYears(from: -2016, to: -2000)
        XCTAssertEqual(leaps, 4, "Expected 4 leap years, was: \(leaps)")
    }

    func testLeapYearsBetween3() {
        let c = ISOChronology()
        let leaps = c.leapYears(from: 0, to: 400)
        XCTAssertEqual(leaps, 97, "Expected 97 leap years, was: \(leaps)")
    }

    func testOrdinal1() {
        let c = ISOChronology()
        let (y, m, d) = c.ordinalDay(year: 2015, days: 366)

        XCTAssertEqual(y, 2016)
        XCTAssertEqual(m, 1)
        XCTAssertEqual(d, 1)
    }

    func testOrdinal2() {
        let c = ISOChronology()
        let (y, m, d) = c.ordinalDay(year: 2015, days: 0)

        XCTAssertEqual(y, 2014)
        XCTAssertEqual(m, 12)
        XCTAssertEqual(d, 31)
    }

    func testOrdinal3() {
        let c = ISOChronology()
        let (y, m, d) = c.ordinalDay(year: 2015, days: -1)

        XCTAssertEqual(y, 2014)
        XCTAssertEqual(m, 12)
        XCTAssertEqual(d, 30)
    }

    func testOrdinal4() {
        let c = ISOChronology()
        let (y, m, d) = c.ordinalDay(year: 2010, days: 59)

        XCTAssertEqual(y, 2010)
        XCTAssertEqual(m, 2)
        XCTAssertEqual(d, 28)
    }

    func testOrdinal5() {
        let c = ISOChronology()
        let (y, m, d) = c.ordinalDay(year: 2010, days: 60)

        XCTAssertEqual(y, 2010)
        XCTAssertEqual(m, 3)
        XCTAssertEqual(d, 1)
    }

    func testToUnixTime1() {
        let d1 = try! LocalDate(year: 2015, month: 1, day: 1)

        XCTAssertEqual(d1.toUnixTime(), 1420070400)
    }


    func testRange1() {
        let d1 = try! LocalDate(year: 2015, dayOfYear: 1)
        let d2 = try! LocalDate(year: 2015, month: 2, day: 1)

        let range = d1..<d2

        XCTAssertEqual(range.count, 31)
        XCTAssertEqual(range.first!, d1)
        XCTAssertFalse(range.contains(d2))
    }

    func testRange2() {
        let d1 = try! LocalDate(year: 2015, dayOfYear: 1)
        let d2 = try! LocalDate(year: 2015, month: 2, day: 1)

        let range = d1...d2

        XCTAssertEqual(range.count, 32)
        XCTAssertEqual(range.first!, d1)
        XCTAssertTrue(range.contains(d2))
    }
}
