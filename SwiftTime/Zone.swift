//
//  Zone.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public protocol TimeZone {

    /// Get the offset from UTC at the time indicated by `temporal`
    func offsetAt<T : Temporal>(temporal: T) -> Seconds

    /// Get the name of the time zone
    func name() -> String

    /// Get the time of the next offset transition, if any
    func nextTransition<T : Temporal>(temporal: T) -> T?

    /// Get the time of the previous offset transition, if any
    func prevTransition<T : Temporal>(temporal: T) -> T?
}

/// An implementation of the TimeZone protocol.
public struct UTC : TimeZone {
    
    public static let instance = UTC()

    private init() {
    }

    /// Get the offset from UTC at the time indicated by `temporal`
    ///
    /// * TODO: This currently always return 0, as no time zones are implemented
    public func offsetAt<T : Temporal>(temporal: T) -> Seconds {
        return 0.seconds
    }

    /// Get the name of the time zone
    public func name() -> String {
        return "UTC"
    }

    public func nextTransition<T : Temporal>(temporal: T) -> T? {
        return nil;
    }

    public func prevTransition<T : Temporal>(temporal: T) -> T? {
        return nil;
    }
}

//
// MARK: Equatable implementation
//

public func == (lhs: TimeZone, rhs: TimeZone) -> Bool {
    return lhs.name() == rhs.name()
}