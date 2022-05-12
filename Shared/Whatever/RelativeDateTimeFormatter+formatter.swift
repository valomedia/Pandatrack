//
//  RelativeDateTimeFormatter+formatter.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-13.
//
//

import Foundation


// MARK: RelativeDateTimeFormatter

// MARK: + formatter

/**
 - Todo: Document.
 */
extension RelativeDateTimeFormatter {

    // MARK: - Static properties

    /**
     - Todo: Document.
     */
    static let formatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter
    }()
}
