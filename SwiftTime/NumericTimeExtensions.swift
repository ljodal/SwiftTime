//
//  NumericTimeExtensions.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

extension Int {
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