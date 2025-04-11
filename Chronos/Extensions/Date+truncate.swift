//
//  Date+truncate.swift
//  Chronos
//
//  Created by Arne Engelland on 11.04.25.
//

 import Foundation

/// Returns the start of the interval for the specified calendar component.
/// - Parameters:
///   - component: The calendar component (e.g., .day, .weekOfYear, .month, etc.) to truncate to.
///   - calendar: The calendar to use; defaults to Calendar.current.
/// - Returns: The start of the interval if available, otherwise the start of the day.
///
 public extension Date {
     func truncate(to component: Calendar.Component, calendar: Calendar = .current) -> Date {
         guard let interval = calendar.dateInterval(of: component, for: self) else {
             return calendar.startOfDay(for: self)
         }
         return interval.start
     }
 }
