//
//  Calendar-Component+CustomStringConvertible.swift
//  Chronos
//

import Foundation


// MARK: Calendar.Component

// MARK: + CustomStringConvertible

extension Calendar.Component: @retroactive CustomStringConvertible {

    public var description: String {
        switch self {

        case .era: return "Era"
        case .year: return "Year"
        case .yearForWeekOfYear: return "Week-Counting Year"
        case .quarter: return "Quarter"
        case .month: return "Month"

        case .weekOfYear: return "Week of the Year"
        case .weekOfMonth: return "Week of the Month"
        case .weekday: return "Weekday"
        case .weekdayOrdinal: return "Weekday Ordinal"
        case .day: return "Day"

        case .hour: return "Hour"
        case .minute: return "Minute"
        case .second: return "Second"
        case .nanosecond: return "Nanosecond"

        case .calendar: return "Calendar"
        case .timeZone: return "Time Zone"

        case .isLeapMonth: return "Is Leap Month"

        case .dayOfYear: return "Day of the Year"

        @unknown default: return "Component"

        }
    }

}
