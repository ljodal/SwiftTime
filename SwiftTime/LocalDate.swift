///
/// A local date, without time zone or offset from UTC
///
/// All calculations assume 24 hours days
///
public struct LocalDate : ForwardIndexType, Comparable {

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
        let chronology = ISOChronology.instance

        guard 1...12 ~= month else {
            throw DateTimeErrors.InvalidDate(message: "Invalid month: \(month)")
        }

        guard 1...chronology.daysInMonth(month: month, year: year) ~= day else {
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
        let chronology = ISOChronology.instance

        // Validate that the given ordinal day is valid
        guard dayOfYear > 0 && Int64(dayOfYear) <= chronology.daysIn(year: year) else {
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
        self.chronology = ISOChronology.instance
    }

    //
    // MARK: Static helpers
    //

    ///
    /// Get the maxiumum representable local date
    ///
    public static func max() -> LocalDate {
        return LocalDate(Int64.max, 12, 31)
    }

    ///
    /// Get the minimum representable local date
    ///
    public static func min() -> LocalDate {
        return LocalDate(Int64.min, 1, 1)
    }

    //
    // MARK: Conversions
    //

    ///
    /// Get the Unix time at midnight
    ///
    public func toUnixTime() -> Int64 {
        return chronology.toEpoch(year: year, month: month, day: day)
    }

    //
    // MARK: ForwardIndexType implementation
    //

    public func successor() -> LocalDate {
        //return self + 1.days
        fatalError("Not implemented")
    }
}

//
// MARK: Equatable and comparable implementation
//

public func == (lhs: LocalDate, rhs: LocalDate) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}

public func <(lhs: LocalDate, rhs: LocalDate) -> Bool {
    return lhs.toUnixTime() < rhs.toUnixTime()
}

//
// MARK: Debug string
//

extension LocalDate : CustomDebugStringConvertible {
    public var debugDescription: String {
        return String(format: "%04d-%02d-%02d", year, month, day)
    }
}