//
//  RelativeDateTimeFormatter+formatter.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-13.
//
//

import Foundation


// MARK: RelativeDateTimeFormatter

extension RelativeDateTimeFormatter {

    // MARK: + formatter

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static let formatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter
    }()

}
