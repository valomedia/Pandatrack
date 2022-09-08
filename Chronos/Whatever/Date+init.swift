//
//  Date+init.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-13.
//
//

import Foundation


// MARK: Date

// MARK: + init

/**
 - Todo: Document.
 */
extension Date {

    // MARK: - Life cycle methods

    /**
     - Todo: Document.
     - Parameter iso8601DateString:
     */
    init?(iso8601DateString: String) {
        guard let date = ISO8601DateFormatter.formatter.date(from: iso8601DateString) else { return nil }
        self = date
    }
}
