//
//  Date+Truncation.swift
//  Chronos
//
//  Created by Arne Engelland on 31.03.25.
//  Description: Provides a Date extension to truncate a date to the start of a specified calendar component.
//

import Foundation

public extension Date {
    /// Returns the start of the interval for the specified calendar component.
    /// - Parameters:
    ///   - component: The calendar component (e.g., .day, .weekOfYear, .month, etc.) to truncate to.
    ///   - calendar: The calendar to use; defaults to Calendar.current.
    /// - Returns: The start of the interval if available, otherwise the start of the day.
    func truncated(to component: Calendar.Component, calendar: Calendar = .current) -> Date {
        guard let interval = calendar.dateInterval(of: component, for: self) else {
            return calendar.startOfDay(for: self)
        }
        return interval.start
    }
}
