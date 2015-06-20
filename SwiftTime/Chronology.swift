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
public protocol Chronology {

    /// Convert the given date into an ordinal day
    func toOrdinalDay(year: Int64, month: Int8, day: Int8) -> Int64

    /// Convert the given ordinal day into a date
    func fromOrdinalDay(day: Int64) -> (year: Int64, month: Int8, day: Int8)

    /// Check if the given year is a leap year
    func isLeapYear(year: Int64) -> Bool

    /// Get the number of days in the given month of the given year
    func daysInMonth(month: Int8, year: Int64) -> Int8
}

public class ISOChronology : Chronology {
    private let minDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private let maxDaysInMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    public init() {}

    public func daysInMonth(month: Int8, year: Int64) -> Int8 {
        if (isLeapYear(year)) {
            return Int8(maxDaysInMonth[month - 1])
        } else {
            return Int8(minDaysInMonth[month - 1])
        }
    }

    public func isLeapYear(year: Int64) -> Bool {
        if year % 4 != 0 {
            return false
        } else if year % 100 != 0 {
            return true
        } else if year % 400 != 0 {
            return false
        } else {
            return true
        }
    }

    public func toOrdinalDay(year: Int64, month: Int8, day: Int8) -> Int64 {
        return 0;
    }

    public func fromOrdinalDay(day: Int64) -> (year: Int64, month: Int8, day: Int8) {
        return (0, 0, 0)
    }

    ///
    /// Get the number of leap years between the given years
    ///
    /// - Parameter from: Start year (inclusive)
    /// - Parameter to  : End year (exclusive)
    ///
    public func leapYears(from from: Int64, to: Int64) -> Int64 {

        // Calculate number of years before the absolute years given.
        // If the given from year is year 0, we include 1 leap year.
        // If the to year is year 0, we set it to 0
        let _from = from == 0 ? 1 : leapYearsBefore(abs(from))
        let _to = to == 0 ? 0 : leapYearsBefore(abs(to))


        // Sumarize, depending on positive or negative years
        var total: Int64 = 0

        if from <= 0 {
            total += _from
        } else {
            total -= _from
        }

        if to <= 0 {
            total -= _to
        } else {
            total += _to
        }


        return total
    }

    ///
    /// Helper function to calculate the number of leap years before a given year
    ///
    /// * Note: Algorithm from [this](http://stackoverflow.com/a/4587611) Stack Overflow answer
    ///
    internal func leapYearsBefore(year: Int64) -> Int64 {
        let y = year - 1
        return (y / 4) - (y / 100) + (y / 400)
    }
}
