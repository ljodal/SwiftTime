//
//  NumericTimeExtensions.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

extension Int {

    public var years: Years {
        get {
            return Years(Int64(self))
        }
    }

    public var months: Months {
        get {
            return Months(Int64(self))
        }
    }

    public var days: Days {
        get {
            return Days(Int64(self))
        }
    }

    public var hours: Hours {
        get {
            return Hours(Int64(self))
        }
    }
    
    public var minutes: Minutes {
        get {
            return Minutes(Int64(self))
        }
    }
    
    public var seconds: Seconds {
        get {
            return Seconds(Int64(self))
        }
    }
}

extension Int8 {

    public var years: Years {
        get {
            return Years(Int64(self))
        }
    }

    public var months: Months {
        get {
            return Months(Int64(self))
        }
    }

    public var days: Days {
        get {
            return Days(Int64(self))
        }
    }

    public var hours: Hours {
        get {
            return Hours(Int64(self))
        }
    }
    
    public var minutes: Minutes {
        get {
            return Minutes(Int64(self))
        }
    }

    public var seconds: Seconds {
        get {
            return Seconds(Int64(self))
        }
    }
}

extension Int16 {

    public var years: Years {
        get {
            return Years(Int64(self))
        }
    }

    public var months: Months {
        get {
            return Months(Int64(self))
        }
    }

    public var days: Days {
        get {
            return Days(Int64(self))
        }
    }

    public var hours: Hours {
        get {
            return Hours(Int64(self))
        }
    }
    
    public var minutes: Minutes {
        get {
            return Minutes(Int64(self))
        }
    }

    public var seconds: Seconds {
        get {
            return Seconds(Int64(self))
        }
    }
}

extension Int32 {

    public var years: Years {
        get {
            return Years(Int64(self))
        }
    }

    public var months: Months {
        get {
            return Months(Int64(self))
        }
    }

    public var days: Days {
        get {
            return Days(Int64(self))
        }
    }

    public var hours: Hours {
        get {
            return Hours(Int64(self))
        }
    }
    
    public var minutes: Minutes {
        get {
            return Minutes(Int64(self))
        }
    }

    public var seconds: Seconds {
        get {
            return Seconds(Int64(self))
        }
    }
}

extension Int64 {

    public var years: Years {
        get {
            return Years(self)
        }
    }

    public var months: Months {
        get {
            return Months(self)
        }
    }

    public var days: Days {
        get {
            return Days(self)
        }
    }

    public var hours: Hours {
        get {
            return Hours(self)
        }
    }
    
    public var minutes: Minutes {
        get {
            return Minutes(self)
        }
    }

    public var seconds: Seconds {
        get {
            return Seconds(self)
        }
    }
}