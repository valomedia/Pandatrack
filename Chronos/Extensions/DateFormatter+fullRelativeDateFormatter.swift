//
//  DateFormatter+fullRelativeDateFormatter.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-05.
//
//

import Foundation


// MARK: DateFormatter

extension DateFormatter {

    // MARK: + fullRelativeDateFormatter

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static let fullRelativeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()

}