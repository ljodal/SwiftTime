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

        // Set variables
        self.year = year
        self.month = month
        self.day = day
        self.chronology = chronology
    }

    ///
    /// Initialize a local date with the given year and ordinal date. If input is not
    /// a valid date, and error is thrown.
    ///
    public init(year: Int64, dayOfYear: Int) throws {
        let chronology = ISOChronology()

        // Validate that the given ordinal day is valid
        guard dayOfYear > 0 && dayOfYear <= chronology.daysIn(year: year) else {
            throw DateTimeErrors.InvalidDate(message: "Invalid date: \(year)-\(dayOfYear)")
        }

        // Convert the ordinal day to a normal date
        let (_y, _m, _d) = chronology.ordinalDay(year: year, days: Int64(dayOfYear))

        // Set variables
        self.year = _y
        self.month = _m
        self.day = _d
        self.chronology = chronology

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
    // MARK: Conversions
    //

    public func toUnixTime() -> Int64 {
        return chronology.toEpoch(year, month: month, day: day)
    }

    //
    // MARK: Arithmithic
    //


    ///
    /// Subtract the given amount of months from this date
    ///
    public func subtract(d: MonthsRepresentableAmount) -> LocalDate {
        return add(Months(-d.months))
    }

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
    /// Subtract the given amount of days from this date
    ///
    public func subtract(d: DaysRepresentableAmount) -> LocalDate {
        return add(Days(-d.days))
    }

    ///
    /// Add the given amount of days to this date
    ///
    public func add(d: DaysRepresentableAmount) -> LocalDate {
        // Get the ordinal day or the year, and add the given number of days
        // to that.
        var day = chronology.ordinalDay(year: self.year, month: month, day: self.day)
        day += d.days

        // Convert ordnial date to year, month, and day. Chronology handles
        // any number of days and will always return a valid date.
        let (y, m, d) = chronology.ordinalDay(year: self.year, days: day)

        // Return a LocaDate. This is guaranteed to not fail, as the values
        // returned from the method above will always be valid
        return LocalDate(y, m, d)
    }
}

//
// MARK: Operators
//

public func + (lhs: LocalDate, rhs: MonthsRepresentableAmount) -> LocalDate {
    return lhs.add(rhs)
}

public func + (lhs: LocalDate, rhs: DaysRepresentableAmount) -> LocalDate {
    return lhs.add(rhs)
}

public func - (lhs: LocalDate, rhs: MonthsRepresentableAmount) -> LocalDate {
    return lhs.subtract(rhs)
}

public func - (lhs: LocalDate, rhs: DaysRepresentableAmount) -> LocalDate {
    return lhs.subtract(rhs)
}

public func == (lhs: LocalDate, rhs: LocalDate) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}