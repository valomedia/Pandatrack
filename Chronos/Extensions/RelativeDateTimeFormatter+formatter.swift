//
//  RelativeDateTimeFormatter+formatter.swift
//  Chronos
//

import Foundation


// MARK: RelativeDateTimeFormatter

extension RelativeDateTimeFormatter {

    // MARK: + formatter

    static let formatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter
    }()

}
