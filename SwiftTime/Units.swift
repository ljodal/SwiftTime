//
//  Units.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

/**
A unit of time
*/
public protocol TemporalUnit {
    /**
    Add `amount` of this unit to the given temporal
    */
    static func addTo<T : Temporal>(temporal: T, amount: Int64) throws -> T
    
    /**
    Get the number of this unit between the two temporals
    */
    static func between<T : Temporal>(start: T, and: T) -> Int64
}

/**
A unit representing an hour
*/
public struct Hours : TemporalUnit, TemporalAmount {
    
    public let count: Int64
    
    public init(_ count: Int64) {
        self.count = count
    }
    
    public func supports(field: TemporalUnit) -> Bool {
        switch field {
        case is Hours:
            return true
        default:
            return false
        }
    }
    
    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Hours:
            return count
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
    
    public static func addTo<T : Temporal>(temporal: T, amount: Int64) throws -> T {
        return temporal.add(amount.hours())

    }
    
    public static func between<T : Temporal>(start: T, and: T) -> Int64 {
        return 0
    }
}

/**
A unit representing a minute
*/
public struct Minutes : TemporalUnit {
    public static func addTo<T : Temporal>(temporal: T, amount: Int64) throws -> T {
        return temporal.add(amount.minutes())
    }
    
    public static func between<T : Temporal>(start: T, and: T) -> Int64 {
        return 0
    }
}

/**
A unit representing a second
*/
public struct Seconds : TemporalUnit {
    public static func addTo<T : Temporal>(temporal: T, amount: Int64) throws -> T {
        return temporal.add(amount.seconds())
    }
    
    public static func between<T : Temporal>(start: T, and: T) -> Int64 {
        return 0
    }
}