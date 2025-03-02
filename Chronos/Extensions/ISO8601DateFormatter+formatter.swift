//
//  ISO8601DateFormatter+formatter.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-13.
//
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
