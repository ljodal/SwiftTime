//
//  LocalDateTest.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 25.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

import XCTest

@testable import SwiftTime

class LocalDateTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /* Crashes. Need to find another way to test this
    func testMax() {
        let d1 = LocalDate.max()
        let d2 = d1 + 1.days
        print(d2)
    }
    */
}
