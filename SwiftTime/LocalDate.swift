//
//  LocalDate.swift
//  SwiftTime
//
//  Created by Sigurd Ljødal on 19.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

/// A struct that represents a date without a time zone, in ISO-chronology
public struct LocalDate : Equatable {

    //
    // MARK: Attributes
    //

    /// Year
    public var year: Int64

    /// Month of the year, 1 indexed
    public var month: Int8

    /// Day of the month, 1 indexed
    public var day: Int8

    // Currently we only support ISO chronology
    private let chronology: ISOChronology

    //
    // MARK: Initializers
    //

    ///
    /// Initializer that validates the input.
    ///
    public init(year: Int64, month: Int8, day: Int8) throws {
        let chronology = ISOChronology()

        guard (1...12).contains(month) else {
            throw DateTimeErrors.InvalidDate(message: "Invalid month: \(month)")
        }

        guard day > 0 && chronology.daysInMonth(month, year: year) >= day else {
            throw DateTimeErrors.InvalidDate(message: "Invalid date: \(year)-\(month)-\(day)")
        }

        self.year = year
        self.month = month
        self.day = day
        self.chronology = chronology
    }

    ///
    /// Initialize a local date with the given year and ordinal date.
    ///
    public init(year: Int64, dayOfYear: Int64) throws {
        let chronology = ISOChronology()

        if dayOfYear > 0 && dayOfYear < (chronology.isLeapYear(year) ? 365 : 366) {
            let (_month, _day) = chronology.ordinalDay(year: year, day: Int64(dayOfYear))

            self.year = year
            self.month = _month
            self.day = _day
            self.chronology = chronology
        } else {
            throw DateTimeErrors.InvalidDate(message: "Invalid ordnial date: \(year)-\(dayOfYear)")
        }
    }

    ///
    /// Private initializer that skips validation
    ///
    private init(_ year: Int64, _ month: Int8, _ day: Int8) {
        self.year = year
        self.month = month
        self.day = day
        self.chronology = ISOChronology()
    }

    //
    // MARK: Arithmithic
    //

    ///
    /// Add the given number of months to this date.
    ///
    /// - Note: If the current day does not exist in the resulting month,
    ///         the last day of the resulting month is used
    ///
    public func add(m: MonthsRepresentableAmount) -> LocalDate {
        var months = Int64(self.month) + m.months
        let addYears = (months / 12)
        var years = self.year + addYears
        months -= addYears * 12

        // If we end up in negative month, we are actually in the previous year
        if months < 1 {
            years -= 1
            months = 12 + months
        }

        // If the day is larger than the last day of the month, we snap
        // to the last day of the month
        var day = self.day
        let last = chronology.daysInMonth(Int8(months), year: years)
        if day > last {
            day = last
        }

        return LocalDate(years, Int8(months), day)
    }

    ///
    /// Add the given amount of days to this date
    ///
    public func add(d: DaysRepresentableAmount) -> LocalDate {
        var dayOfYear = chronology.ordinalDay(year: self.year, month: month, day: day)
        dayOfYear += d.days
        var year = self.year

        if dayOfYear > Int64(chronology.isLeapYear(year) ? 365 : 366) {
            year += Int64(Double(dayOfYear) / 365.2524)
            dayOfYear -= chronology.daysBetween(from: self.year, to: year)
        }

        return try! LocalDate(year: year, dayOfYear: dayOfYear)
    }
}

//
// MARK: Operators
//

public func +(lhs: LocalDate, rhs: MonthsRepresentableAmount) -> LocalDate {
    return lhs.add(rhs)
}

public func +(lhs: LocalDate, rhs: DaysRepresentableAmount) -> LocalDate {
    return lhs.add(rhs)
}

public func ==(lhs: LocalDate, rhs: LocalDate) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}