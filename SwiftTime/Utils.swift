//
//  GregorianCalendar.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

private let minDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
private let maxDaysInMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

func daysInMonth(month: Int8, year: Int64) -> Int8 {
    print("Days: \(year)-\(month)")
    if (isLeapYear(year)) {
        return Int8(maxDaysInMonth[month - 1])
    } else {
        return Int8(minDaysInMonth[month - 1])
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