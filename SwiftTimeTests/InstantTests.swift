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
        for _ in 0..<10 {
            let i = Instant.now()

            print(i)
        }
    }
}