//
//  Chronology.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 19.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

///
/// A protocol for chronoology helpers
///
internal protocol Chronology {

    /// Convert the given date into an ordinal day
    func ordinalDay(year year: Int64, month: Int8, day: Int8) -> Int64

    /// Convert the given ordinal day into a date
    func ordinalDay(year year: Int64, days: Int64) -> (Int64, Int8, Int8)

    /// Check if the given year is a leap year
    func isLeapYear(year: Int64) -> Bool

    /// Get the number of days in the given month of the given year
    func daysInMonth(month month: Int8, year: Int64) -> Int8

    /// Get the number of seconds since the epoch, given the arguments
    func toEpoch(year year: Int64, month: Int8, day: Int8) -> Int64

    /// Get the components from the given seconds since the epoch
    func fromEpoch(seconds: Int64) -> (Int64, Int8, Int8)

    /// Validate that this is a valid combination of components
    func validate(year: Int64, _ month: Int8, _ day: Int8,
        _ hours: Int8, _ minutes: Int8, _ seconds: Int8, _ nanos: Int32) throws;
}

internal class ISOChronology : Chronology {

    // Look-up tables for days in months
    private let minDaysInMonth: [Int8] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private let maxDaysInMonth: [Int8] = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    // Loop-up tables for first day of month
    private let minFirstDayOfMonth: [Int64] = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
    private let maxFirstDayOfMonth: [Int64] = [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335]

    internal static let instance = ISOChronology()

    private init() {}

    ///
    /// Get the number of days in the given month
    ///
    internal func daysInMonth(month month: Int8, year: Int64) -> Int8 {
        if (isLeapYear(year)) {
            return maxDaysInMonth[month - 1]
        } else {
            return minDaysInMonth[month - 1]
        }
    }

    ///
    /// Check if the given year is a leap year
    ///
    internal func isLeapYear(year: Int64) -> Bool {
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
    /// Convert from year, month and date to ordinal day
    ///
    internal func ordinalDay(year year: Int64, month: Int8, day: Int8) -> Int64 {
        if isLeapYear(year) {
            return maxFirstDayOfMonth[month - 1] + Int64(day)
        } else {
            return minFirstDayOfMonth[month - 1] + Int64(day)
        }
    }

    ///
    /// Convert the year and ordinal date to year, month and date
    ///
    /// - Note: Supports any number of days, so year can change.
    /// - Note:
    ///
    internal func ordinalDay(year year: Int64, days: Int64) -> (Int64, Int8, Int8) {

        // First find out which year we end up in
        var y = year + estimatedYears(days: days)
        var d = daysBetween(from: year, to: y)

        if days < d {
            y -= 1
            d = daysBetween(from: year, to: y)
        }

        // Resulting ordinal day
        d = days - d

        // If day is less than one, we end up in the previous year
        if d < 1 {
            y--
            d = daysIn(year: y) + d
        }

        // Find out which month we are in
        let (month, day) = fromOrdinal(year: y, days: d)

        return (y, month, day)
    }

    ///
    /// Get the month that the given ordinal day is in in the given year
    ///
    private func fromOrdinal(year year: Int64, days: Int64) -> (Int8, Int8) {
        // Cached reference to the first day of month array
        let firstDay = isLeapYear(year) ? maxFirstDayOfMonth : minFirstDayOfMonth

        // Estimate the month and get the first day in that month
        var estimatedMonth = Int8(days / 31) + 1
        let firstOfMonth = firstDay[estimatedMonth - 1]

        // If days is less than the first day of the estimated month,
        // we are in the previous month. If days is higher than the first
        // day of the next month, we are in the next month
        if days <= Int64(firstOfMonth) {
            estimatedMonth--
        } else if estimatedMonth < 12 && days > firstDay[Int(estimatedMonth)] {
            estimatedMonth++
        }

        // Calculate day of month
        let day = Int8(days - firstDay[estimatedMonth - 1])

        // Return day and month
        return (estimatedMonth, day)
    }

    ///
    /// Get the estimated number of years that this number of days represents
    ///
    private func estimatedYears(days days: Int64) -> Int64 {
        return days / 365
    }

    ///
    /// Get the number of days between the given years
    ///
    /// - Parameter from: Start year (inclusive)
    /// - Parameter to  : End year (exclusive)
    ///
    internal func daysBetween(from from: Int64, to: Int64) -> Int64 {
        var days = (to - from) * 365
        days += leapYears(from: from, to: to)
        return days
    }

    ///
    /// Get the number of years in the given year
    ///
    internal func daysIn(year year: Int64) -> Int64 {
        return isLeapYear(year) ? 366 : 365
    }

    ///
    /// Get the number of leap years between the given years
    ///
    /// - Parameter from: Start year (inclusive)
    /// - Parameter to  : End year (exclusive)
    ///
    internal func leapYears(from from: Int64, to: Int64) -> Int64 {

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
    private func leapYearsBefore(year: Int64) -> Int64 {
        let y = year - 1
        return (y / 4) - (y / 100) + (y / 400)
    }

    //
    // MARK: Convert to and from unix epoch
    //

    ///
    /// Get the number of seconds since the Unix Epoch (1970-01-01)
    ///
    internal func toEpoch(year year: Int64, month: Int8, day: Int8) -> Int64 {
        var days: Int64 = 0

        // Add days from 1970 to the given year
        days += daysBetween(from: 1970, to: year)

        // Add the ordinal day of the given date, minus one because we
        // want the number of seconds until the given date, not including
        days += ordinalDay(year: year, month: month, day: day) - 1

        // Number of days in seconds
        return days * 86_400
    }

    ///
    /// Get the date components from the given number of seconds since
    /// the Unix Epoch (1970-01-01)
    ///
    internal func fromEpoch(var seconds: Int64) -> (Int64, Int8, Int8) {

        // If seconds is less than 0, we must subtract 86 399 seconds.
        // This makes sure that the division below return the correct
        // day, as any number of seconds except the first of a day will
        // otherwise be counted in the next day.
        if seconds < 0 {
            seconds -= 86_399
        }

        // Get the number of whole days
        var days: Int64 = seconds / Int64(86_400)

        // Estimate the year we end up in based on the number of days
        var year = estimatedYears(days: days) + 1970

        // Calculate the actual number of days in the estimated number
        // of months. This helps us calculate the exact date we end at
        if year < 1970 {
            days -= daysBetween(from: year, to: 1970)
        } else {
            days -= daysBetween(from: 1970, to: year)
        }

        // Get the number of days in the estimated year
        let daysInYear = daysIn(year: year)

        // Days should be counted from 1, not 0
        days += 1

        // Check that we are within the bounds of the given year
        if days < 1 {
            year -= 1
            days = daysInYear + days
        } else if days > daysInYear {
            year += 1
            days = days - daysInYear
        }

        // Get the month and day
        let (month, day) = fromOrdinal(year: year, days: days)

        // Return components
        return (year, month, day)
    }

    /// Validate that the given components are valid
    internal func validate(year: Int64, _ month: Int8, _ day: Int8,
        _ hours: Int8, _ minutes: Int8, _ seconds: Int8, _ nanos: Int32) throws
    {
        guard 1...12 ~= month else {
            throw DateTimeErrors.InvalidDate(message: "Invalid month: \(month)")
        }

        guard 1...daysInMonth(month: month, year: year) ~= day else {
            throw DateTimeErrors.InvalidDate(message: String(
                format: "Invalid date: %04d-%02d-%02d", year, month, day))
        }

        guard 0...23 ~= hours else {
            throw DateTimeErrors.InvalidTime(message: "Invalid hour: \(hours)")
        }

        guard 0...59 ~= minutes else {
            throw DateTimeErrors.InvalidTime(message: "Invalid minute: \(minutes)")
        }

        guard 0...59 ~= seconds else {
            throw DateTimeErrors.InvalidTime(message: "Invalid second: \(seconds)")
        }

        guard 0...999_999_999 ~= nanos else {
            throw DateTimeErrors.InvalidTime(message: "Invalid nanos: \(nanos)")
        }
    }
}
