//
//  Chronology.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 19.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

class Chronology {
    private let minDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private let maxDaysInMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    func daysInMonth(month: Int, year: Int64) throws -> Int {
        if (isLeapYear(year)) {
            return maxDaysInMonth[month - 1]
        } else {
            return minDaysInMonth[month - 1]
        }
    }

    func isLeapYear(year: Int64) -> Bool {
        if year % 400 == 0 {
            return true
        } else if year % 100 == 0 {
            return false
        } else if year % 4 == 0 {
            return true
        } else {
            return false
        }
    }
}