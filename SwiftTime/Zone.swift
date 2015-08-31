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
}

/// An implementation of the TimeZone protocol.
public struct TZ : TimeZone {
    
    public static let UTC = try! TZ.get("UTC")

    /// Get the zone for the given name. If no such zone exists, an error is thrown
    public static func get(name: String) throws -> TZ {
        return TZ(name)
    }

    private init(_ name: String) {

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
}

//
// MARK: Equatable implementation
//

public func == (lhs: TimeZone, rhs: TimeZone) -> Bool {
    return lhs.name() == rhs.name()
}