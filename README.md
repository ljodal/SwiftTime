# SwiftTime
The goal of this project is to implement a flexible, highly performant and
dependency free date and time libary for Swift.

Parts of the library is modeled after the Java 8 Time API, with additions
of custom operators and other Swift features that are not available in
Java.

The plan is to have support for:

 * DateTime with TimeZone
 * Instant (Seconds since epoch)
 * Adding and subtracting
 * Parsing and formatting (strptime/strftime or similar)

