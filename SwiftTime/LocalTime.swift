///
/// Local time, without time zone or offset from UTC
///
/// Represents the time of day
///
public struct LocalTime : Comparable {

    //
    // MARK: Properties
    //

    /// Hours since midnight
    public var hour: Int8

    /// Minutes into hour
    public var minute: Int8

    /// Seconds into minute
    public var second: Int8

    /// Nano seconds into second
    public var nanos: Int32

    /// Get the number of seconds into the day that this time represents
    public var secondsOfDay: Int64 {
        return Int64(hour) * 3600 + Int64(minute) * 60 + Int64(second)
    }

    //
    // MARK: Initializers
    //

    ///
    /// Initialize with the given fields.
    ///
    /// - Note: Raises an error if the given time is not valid
    ///
    public init(hour: Int8 = 0, minute: Int8 = 0, second: Int8 = 0, nanos: Int32 = 0) throws {

        guard 0...23 ~= hour else {
            throw DateTimeErrors.InvalidTime(message: "Invalid hour: \(hour)")
        }

        guard 0...59 ~= minute else {
            throw DateTimeErrors.InvalidTime(message: "Invalid minute: \(minute)")
        }

        guard 0...59 ~= second else {
            throw DateTimeErrors.InvalidTime(message: "Invalid second: \(second)")
        }

        guard 0...999_999_999 ~= nanos else {
            throw DateTimeErrors.InvalidTime(message: "Invalid nanos: \(nanos)")
        }

        self.hour = hour
        self.minute = minute
        self.second = second
        self.nanos = nanos
    }

    ///
    /// Private non-validating initializer
    ///
    private init(_ hour: Int8, _ minute: Int8, _ second: Int8, _ nanos: Int32) {
        self.hour = hour
        self.minute = minute
        self.second = second
        self.nanos = nanos
    }
}

//
// MARK: Equatable and Comparable implemention
//

public func == (lhs: LocalTime, rhs: LocalTime) -> Bool {
    return (
        lhs.hour == rhs.hour &&
        lhs.minute == rhs.minute &&
        lhs.second == rhs.second &&
        lhs.nanos == rhs.nanos
    )
}

public func < (lhs: LocalTime, rhs: LocalTime) -> Bool {
    let lhsSec = lhs.secondsOfDay
    let rhsSec = rhs.secondsOfDay
    if lhsSec < rhsSec {
        return true
    } else if lhsSec == rhsSec {
        return lhs.nanos < rhs.nanos
    } else {
        return false
    }
}