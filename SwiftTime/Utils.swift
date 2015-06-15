//
//  GregorianCalendar.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

let daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

func daysInMonth(month: Int, year: Int64) throws -> Int {
    switch month {
    case 1:
        return daysInMonth[0]
    case 2:
        return isLeapYear(year) == true ? 29 : 28
    case 3...12:
        return daysInMonth[month - 1]
    default:
        throw DateTimeErrors.InvalidMonth
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