//
//  DateTime.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

/**
 * A struct that stores the number of nano seconds since
 * Unix Epoch (1970-01-01)
 */
public struct Instant : Temporal {
    public let seconds : Int64
    public let nanos : Int32
    
    public init(seconds: Int64) {
        self.seconds = seconds
        self.nanos = 0
    }
    
    public init(seconds: Int64, nanos: Int32) {
        self.seconds = seconds
        self.nanos = nanos
    }
    
    public init(millis: Int64) {
        self.seconds = millis / 1_000
        self.nanos = Int32(millis % 1_000) * 1_000_000
    }
    
    public func add(unit: TemporalUnit, amount: Int64) -> Instant {
        return self
    }
    
    public func add(amount: TemporalAmount) -> Instant {
        switch amount {
        case is Duration:
            let seconds = try! self.seconds + amount.get(Seconds())
            let nanos = self.nanos
            return Instant(seconds: seconds, nanos: nanos)
        default:
            return self
        }
    }
}


public func == (lhs: Instant, rhs: Instant) -> Bool {
    return lhs.seconds == rhs.seconds && lhs.nanos == rhs.nanos
}