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
        
        assert(d2.seconds == 246)
        assert(d2.nanos == 0)
    }
    
    func testEquals() {
        let d1 = Instant(seconds: 123)
        let d2 = Instant(seconds: 123)
        
        assert(d1 == d2)
    }
    
    func testNotEquals() {
        let d1 = Instant(seconds: 123)
        let d2 = Instant(seconds: 234)
        
        assert(d1 != d2)
    }

    func testAdd() {
        var h1 = 1.hours
        h1 += 2.hours

        assert(h1 == 3.hours)
    }
}
