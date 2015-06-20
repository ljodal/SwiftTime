//
//  SwiftTimeTests.swift
//  SwiftTimeTests
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

import XCTest

import SwiftTime

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
        
        XCTAssert(d2.seconds == 246)
        XCTAssert(d2.nanos == 0)
    }
    
    func testEquals() {
        let d1 = Instant(seconds: 123)
        let d2 = Instant(seconds: 123)
        
        XCTAssert(d1 == d2)
    }
    
    func testNotEquals() {
        let d1 = Instant(seconds: 123)
        let d2 = Instant(seconds: 234)
        
        XCTAssert(d1 != d2)
    }

    func testAdd() {
        var h1 = 1.hours
        h1 += 2.hours

        XCTAssert(h1 == 3.hours)
        XCTAssert(h1 != 1.hours)
    }

    func testAdd2() {
        let h1 = 1.hours + 30.minutes

        XCTAssert(h1 == 5400.seconds)
        XCTAssert(h1 != 5432.seconds)
    }

    func testLocalDate1() {
        let d1 = try! LocalDate(year: 2015, month: 1, day: 31)
        let d2 = d1 + 1.months
        let d3 = try! LocalDate(year: 2015, month: 2, day: 28)

        XCTAssert(d2 == d3)
    }

    func testLocalDate2() {
        let d1 = try! LocalDate(year: 2015, month: 12, day: 31)
        let d2 = d1 + 0.months
        let d3 = try! LocalDate(year: 2015, month: 12, day: 31)

        XCTAssert(d2 == d3)
    }

    func testLocalDate3() {
        do {
            let d1 = try LocalDate(year: 2015, month: 1, day: 1)
            let d2 = d1 + (-1).months
            let d3 = try LocalDate(year: 2014, month: 12, day: 1)

            XCTAssert(d2 == d3)
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

            XCTAssert(d2 == d3)
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

            XCTAssert(d2 == d3)
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

            XCTAssert(d2 == d3)
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

            XCTAssert(d2 == d3)
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

            XCTAssert(d2 == d3)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testOrdinalDate() {
        do {
            let d1 = try LocalDate(year: 2000, dayOfYear: 28)
            let d2 = try LocalDate(year: 2000, month: 1, day: 28)

            XCTAssert(d1 == d2)
        } catch DateTimeErrors.InvalidDate(let message) {
            XCTAssert(false, message)
        } catch {
            XCTAssert(false, "Error occured: \(error)")
        }
    }

    func testLeapYearsBetween1() {
        let c = ISOChronology()
        let leaps = c.leapYears(from: 2000, to: 2016)
        XCTAssert(leaps == 4, "Expected 4 leap years, was: \(leaps)")
    }

    func testLeapYearsBetween2() {
        let c = ISOChronology()
        let leaps = c.leapYears(from: -2016, to: -2000)
        XCTAssert(leaps == 4, "Expected 4 leap years, was: \(leaps)")
    }

    func testLeapYearsBetween3() {
        let c = ISOChronology()
        let leaps = c.leapYears(from: 0, to: 400)
        XCTAssert(leaps == 97, "Expected 97 leap years, was: \(leaps)")
    }
}
