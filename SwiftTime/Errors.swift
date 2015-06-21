//
//  Errors.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

public enum DateTimeErrors : ErrorType {
    case UnsupportedUnit
    case InvalidMonth(value: Int8)
    case InvalidDate(message: String)
    case InvalidTime(message: String)
    case UnsupportedAmount
}