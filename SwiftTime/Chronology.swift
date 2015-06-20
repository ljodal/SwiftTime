//
//  Chronology.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 19.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

import Darwin

///
/// A protocol for chronoology helpers
///
protocol Chronology {

    /// Convert the given date into an ordinal day
    func toOrdinalDay(year: Int64, month: Int8, day: Int8) -> Int64

    /// Convert the given ordinal day into a date
    func fromOrdinalDay(day: Int64) -> (year: Int64, month: Int8, day: Int8)

    /// Check if the given year is a leap year
    func isLeapYear(year: Int64) -> Bool

    /// Get the number of days in the given month of the given year
    func daysInMonth(month: Int8, year: Int64) -> Int8
}

class ISOChronology : Chronology {
    private let minDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private let maxDaysInMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    func daysInMonth(month: Int8, year: Int64) -> Int8 {
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

    func toOrdinalDay(year: Int64, month: Int8, day: Int8) -> Int64 {
        return 0;
    }

    func fromOrdinalDay(day: Int64) -> (year: Int64, month: Int8, day: Int8) {
        return (0, 0, 0)
    }
}