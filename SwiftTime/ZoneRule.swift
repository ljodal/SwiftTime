///
/// A zone rule, that has a number of entries at which the
/// offset from UTC changes. A zone rule can be used in
/// multiple zones.
///
internal struct ZoneRule {

    /// Rule name
    internal let name: String

    /// Rule entries
    internal let entries: [RuleEntry]
}

///
/// A rule entry. Essentially a rule telling when a change
/// in offset from UTC occurs and what the change is.
///
/// - Note: This currently only support changes at specific
///         dates, not e.g. last sunday in the month
///
internal struct RuleEntry {

    /// Start year of the entry
    internal let yearFrom: Int64

    /// End year of the entry
    internal let yearTo: Int64

    /// Month at which the entry occurs
    internal let month: Int8

    /// Day at which the entry occurs
    internal let day: Int8

    /// Seconds to save (additional offset from the standard time)
    internal let save: Int

    /// Letters to insert into zone-name format
    internal let letters: String
}