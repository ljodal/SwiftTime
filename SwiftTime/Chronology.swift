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
    func ordinalDay(year year: Int64, month: Int8, day: Int8) -> Int64

    /// Convert the given ordinal day into a date
    func ordinalDay(year year: Int64, day: Int64) -> (Int8, Int8)

    /// Check if the given year is a leap year
    func isLeapYear(year: Int64) -> Bool

    /// Get the number of days in the given month of the given year
    func daysInMonth(month: Int8, year: Int64) -> Int8
}

public class ISOChronology : Chronology {

    // Look-up tables for days in months
    private let minDaysInMonth: [Int8] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private let maxDaysInMonth: [Int8] = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    // Loop-up tables for first day of month
    private let minFirstDayOfMonth: [Int64] = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
    private let maxFirstDayOfMonth: [Int64] = [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335]

    public init() {}

    ///
    /// Get the number of days in the given month
    ///
    public func daysInMonth(month: Int8, year: Int64) -> Int8 {
        if (isLeapYear(year)) {
            return maxDaysInMonth[month - 1]
        } else {
            return minDaysInMonth[month - 1]
        }
    }

    ///
    /// Check if the given year is a leap year
    ///
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

    ///
    /// Convert from year, month and date to ordinal date
    ///
    public func ordinalDay(year year: Int64, month: Int8, day: Int8) -> Int64 {
        if isLeapYear(year) {
            return maxFirstDayOfMonth[month - 1] + Int64(day)
        } else {
            return minFirstDayOfMonth[month - 1] + Int64(day)
        }
    }

    ///
    /// Convert from year and ordinal date to month and day
    ///
    public func ordinalDay(year year: Int64, day: Int64) -> (Int8, Int8) {

        let days = isLeapYear(year) ? maxDaysInMonth : minDaysInMonth

        // TODO: Über-naive implementation. Should be fixed
        var _day = day
        var _month = 1
        for i in 0...11 {
            let d = Int64(days[i])
            if _day > d {
                _month += 1
                _day -= d
            } else {
                break
            }
        }

        return (Int8(_month), Int8(_day))
    }

    ///
    /// Get the number of days between the given years
    ///
    /// - Parameter from: Start year (inclusive)
    /// - Parameter to  : End year (exclusive)
    ///
    public func daysBetween(from from: Int64, to: Int64) -> Int64 {
        var days = (to - from) * 365
        days += leapYears(from: from, to: to)
        return days
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
