//
//  Temporal.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public protocol Temporal {

    ///
    /// Get the number of milli seconds since the UNIX epoch
    ///
    func toMillis() -> Int64
}

public protocol TemporalMath : Equatable {

    //
    // Addition and subtraction
    //

    func add<T : SecondsRepresentableAmount> (amount: T) -> Self
    func add<T : NanoSecondsRepresentableAmount> (amount: T) -> Self
    func add(amount: Duration) -> Self
    func add(amount: Period) -> Self

    func subtract<T : SecondsRepresentableAmount>(amount: T) -> Self
    func subtract<T : NanoSecondsRepresentableAmount>(amount: T) -> Self
    func subtract(amount: Duration) -> Self
    func subtract(amount: Period) -> Self
}

public func +<T : TemporalMath, U : SecondsRepresentableAmount> (lhs: T, rhs: U) -> T {
    return lhs.add(rhs)
}

public func +<T : TemporalMath, U : NanoSecondsRepresentableAmount> (lhs: T, rhs: U) -> T {
    return lhs.add(rhs)
}

public func +<T : TemporalMath> (lhs: T, rhs: Duration) -> T {
    return lhs.add(rhs)
}

public func +<T : TemporalMath> (lhs: T, rhs: Period) -> T {
    return lhs.add(rhs)
}

public func -<T : TemporalMath, U : SecondsRepresentableAmount> (lhs: T, rhs: U) -> T {
    return lhs.subtract(rhs)
}

public func -<T : TemporalMath, U : NanoSecondsRepresentableAmount> (lhs: T, rhs: U) -> T {
    return lhs.subtract(rhs)
}

public func -<T : TemporalMath> (lhs: T, rhs: Duration) -> T {
    return lhs.subtract(rhs)
}

public func -<T : TemporalMath> (lhs: T, rhs: Period) -> T {
    return lhs.subtract(rhs)
}