//
//  ZoneTests.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 20.09.2015.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//


import XCTest

@testable import SwiftTime

class ZoneTests: XCTestCase {

    func testOffsets() {
        let transitions: [Int64] = [
            1000,2000,3000,4000,5000,6000,7000,8000,9000
        ]

        let offsets: [Int64] = [
            1,2,3,4,5,6,7,8,9
        ]

        let zone = PrecalculatedZone(
            transitions: transitions,
            offsets: offsets,
            standardOffset: 0,
            name: "Test"
        )

        XCTAssertEqual(1, zone.offsetAt(1000))
        XCTAssertEqual(1, zone.offsetAt(1001))
        XCTAssertEqual(1, zone.offsetAt(1010))
        XCTAssertEqual(1, zone.offsetAt(1999))

        XCTAssertEqual(0, zone.offsetAt(999))
        XCTAssertEqual(2, zone.offsetAt(2000))
        XCTAssertEqual(8, zone.offsetAt(8999))
        XCTAssertEqual(9, zone.offsetAt(9000))
        XCTAssertEqual(9, zone.offsetAt(20000))
        XCTAssertEqual(9, zone.offsetAt(Int64.max))
        XCTAssertEqual(0, zone.offsetAt(Int64.min))
    }

    func testPerformance() {
        let transitions: [Int64] = (0..<1000000).map{i in Int64(i)}

        let offsets: [Int64] = transitions;

        let zone = PrecalculatedZone(
            transitions: transitions,
            offsets: offsets,
            standardOffset: 0,
            name: "Test"
        )

        self.measureBlock {
            var offset: Int64 = 0;
            for _ in 0..<100000 {
                offset += zone.offsetAt(123456789)
            }
        }
    }
}