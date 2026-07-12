//
//  ISO8601DateFormatter+formatter.swift
//  Chronos
//

import Foundation


// MARK: ISO8601DateFormatter

extension ISO8601DateFormatter {

    // MARK: + formatter

    static let formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        formatter.timeZone = TimeZone.current
        return formatter
    }()

}
