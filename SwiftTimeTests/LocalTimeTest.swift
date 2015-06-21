//
//  LocalTimeTest.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 21.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

import XCTest

@testable import SwiftTime

class LocalTimeTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreate1() {
        let _ = try! LocalTime(hour: 12, minute: 12, second: 12, nanos: 12)
    }

    func testCreate2() {
        let _ = try! LocalTime(hour: 23, minute: 59, second: 59, nanos: 999_999_999)
    }

    func testExpectedFailedCreate1() {
        do {
            let _ = try LocalTime(hour: 24, minute: 0, second: 0, nanos: 0)
        } catch DateTimeErrors.InvalidTime {
            return
        } catch {
            XCTFail("Unexpected exception: \(error)")
        }

        XCTFail("Expected exception")
    }


    func testExpectedFailedCreate2() {
        do {
            let _ = try LocalTime(hour: 0, minute: 60, second: 0, nanos: 0)
        } catch DateTimeErrors.InvalidTime {
            return
        } catch {
            XCTFail("Unexpected exception: \(error)")
        }

        XCTFail("Expected exception")
    }


    func testExpectedFailedCreate3() {
        do {
            let _ = try LocalTime(hour: 0, minute: 0, second: 60, nanos: 0)
        } catch DateTimeErrors.InvalidTime {
            return
        } catch {
            XCTFail("Unexpected exception: \(error)")
        }

        XCTFail("Expected exception")
    }


    func testExpectedFailedCreate4() {
        do {
            let _ = try LocalTime(hour: 0, minute: 0, second: 0, nanos: 1_000_000_000)
        } catch DateTimeErrors.InvalidTime {
            return
        } catch {
            XCTFail("Unexpected exception: \(error)")
        }

        XCTFail("Expected exception")
    }

    func testInterval1() {
        let t1 = try! LocalTime(hour: 10, minute: 0, second: 0, nanos: 0)
        let t2 = try! LocalTime(hour: 11, minute: 0, second: 0, nanos: 0)
        let t3 = try! LocalTime(hour: 12, minute: 0, second: 0, nanos: 0)

        XCTAssertTrue(t1...t3 ~= t2)
    }

    func testInterval2() {
        let t1 = try! LocalTime(hour: 10, minute: 0, second: 0, nanos: 0)
        let t2 = try! LocalTime(hour: 11, minute: 0, second: 0, nanos: 0)

        XCTAssertTrue(t1...t2 ~= t2)
    }

    func testInterval3() {
        let t1 = try! LocalTime(hour: 10, minute: 0, second: 0, nanos: 0)
        let t2 = try! LocalTime(hour: 11, minute: 0, second: 0, nanos: 0)

        XCTAssertFalse(t1..<t2 ~= t2)
    }
}
