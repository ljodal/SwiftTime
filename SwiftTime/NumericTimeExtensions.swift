//
//  NumericTimeExtensions.swift
//  SwiftDateTime
//
//  Created by Sigurd Ljødal on 15.06.15.
//  Copyright © 2015 Sigurd Ljødal. All rights reserved.
//

extension Int {
    public func hours() -> Duration {
        return Duration(seconds: Int64(self) * 60 * 60, nanoSeconds: 0)
    }
    
    public func minutes() -> Duration {
        return Duration(seconds: Int64(self) * 60, nanoSeconds: 0)
    }
    
    public func seconds() -> Duration {
        return Duration(seconds: Int64(self), nanoSeconds: 0)
    }
}

extension Int8 {
    public func hours() -> Duration {
        return Duration(seconds: Int64(self) * 86400, nanoSeconds: 0)
    }
    
    public func minutes() -> Duration {
        return Duration(seconds: Int64(self) * 60, nanoSeconds: 0)
    }
    
    public func seconds() -> Duration {
        return Duration(seconds: Int64(self), nanoSeconds: 0)
    }
}

extension Int16 {
    public func hours() -> Duration {
        return Duration(seconds: Int64(self) * 86400, nanoSeconds: 0)
    }
    
    public func minutes() -> Duration {
        return Duration(seconds: Int64(self) * 60, nanoSeconds: 0)
    }
    
    public func seconds() -> Duration {
        return Duration(seconds: Int64(self), nanoSeconds: 0)
    }
}

extension Int32 {
    public func hours() -> Duration {
        return Duration(seconds: Int64(self) * 86400, nanoSeconds: 0)
    }
    
    public func minutes() -> Duration {
        return Duration(seconds: Int64(self) * 60, nanoSeconds: 0)
    }
    
    public func seconds() -> Duration {
        return Duration(seconds: Int64(self), nanoSeconds: 0)
    }
}

extension Int64 {
    public func hours() -> Duration {
        return Duration(seconds: self * 86400, nanoSeconds: 0)
    }
    
    public func minutes() -> Duration {
        return Duration(seconds: Int64(self) * 60, nanoSeconds: 0)
    }
    
    public func seconds() -> Duration {
        return Duration(seconds: Int64(self), nanoSeconds: 0)
    }
}