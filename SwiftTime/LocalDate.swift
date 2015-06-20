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

    public var year: Int64
    public var month: Int8
    public var day: Int8

    //
    // MARK: Initializers
    //

    ///
    /// Initializer that validates the input.
    ///
    public init(year: Int64, month: Int8, day: Int8) throws {
        guard (1...12).contains(month) else {
            throw DateTimeErrors.InvalidDate(message: "Invalid month: \(month)")
        }

        guard day > 0 && daysInMonth(month, year: year) >= day else {
            throw DateTimeErrors.InvalidDate(message: "Invalid date: \(year)-\(month)-\(day)")
        }

        self.year = year
        self.month = month
        self.day = day
    }

    ///
    /// Private initializer that skips validation
    ///
    private init(_ year: Int64, _ month: Int8, _ day: Int8) {
        self.year = year
        self.month = month
        self.day = day
    }

    //
    // MARK: Arithmithic
    //

    ///
    /// Add the given number of months to this date.
    ///
    /// * Note: If the current day does not exist in the resulting month,
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
        let last = daysInMonth(Int8(months), year: years)
        if day > last {
            day = last
        }

        return LocalDate(years, Int8(months), day)
    }
}

//
// MARK: Operators
//

public func +(lhs: LocalDate, rhs: MonthsRepresentableAmount) -> LocalDate {
    return lhs.add(rhs)
}

public func ==(lhs: LocalDate, rhs: LocalDate) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}