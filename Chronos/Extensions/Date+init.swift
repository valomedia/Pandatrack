//
//  Date+init.swift
//  Chronos
//

import Foundation


// MARK: Date

extension Date {

    // MARK: + init

    init?(iso8601DateString: String) {
        guard let date = ISO8601DateFormatter.formatter.date(from: iso8601DateString) else { return nil }
        self = date
    }

}
