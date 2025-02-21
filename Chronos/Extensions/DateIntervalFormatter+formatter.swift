//
//  DateIntervalFormatter+formatter.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-12.
//
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
