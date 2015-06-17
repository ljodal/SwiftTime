//
//  Duration.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

/**
An amount of time
*/
public protocol TemporalAmount {
    func supports(field: TemporalUnit) -> Bool
    func get(unit: TemporalUnit) throws -> Int64
}

/**
An amount of time in seconds and nano seconds
*/
public struct Duration : TemporalAmount {
    public let seconds: Int64
    public let nanoSeconds: Int64
    
    public init(seconds: Int64, nanoSeconds: Int64) {
        self.seconds = seconds
        self.nanoSeconds = nanoSeconds
    }
    
    public func supports(field: TemporalUnit) -> Bool {
        return false
    }
    
    public func get(unit: TemporalUnit) throws -> Int64 {
        switch unit {
        case is Seconds:
            return seconds
        default:
            throw DateTimeErrors.UnsupportedUnit
        }
    }
}

/**
An amount of time in years, months, and days.
*/
public struct Period : TemporalAmount {
    public let years: Int64
    public let months: Int64
    public let days: Int64
    
    public init(years: Int64, months: Int64, days: Int64) {
        self.years = years
        self.months = months
        self.days = days
    }
    
    public func supports(unit: TemporalUnit) -> Bool {
        return false
    }
    
    /**
    __Throws:__ if the given field is not supported
    
    - Parameter field The field to get
    */
    public func get(field: TemporalUnit) throws -> Int64 {
        throw DateTimeErrors.UnsupportedUnit
    }
}