//
//  DateIntervalFormatter+formatter.swift
//  Chronos
//

import Foundation


// MARK: DateIntervalFormatter

extension DateIntervalFormatter {

    // MARK: + formatter

    static let formatter: DateIntervalFormatter = {
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
}
