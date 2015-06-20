# SwiftTime
The goal of this project is to implement a flexible, highly performant and
dependency free date and time libary for Swift.

Parts of the library are modelled after the Java library Joda-Time, the Java 8
Time API and Ruby/Rails time handling. 

The plan is to have support for:

 * DateTime with TimeZone
 * Instant (Seconds since the UNIX epoch)
 * Adding and subtracting
 * Parsing and formatting (strptime/strftime or similar)

To goal is to support different types of chronology, but to begin with only
Gregorian/ISO8601 chronology will be implemented.
