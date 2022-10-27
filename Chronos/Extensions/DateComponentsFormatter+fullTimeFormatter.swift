//
//  DateComponentsFormatter+fullTimeFormatter.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: DateCompontentsFormatter

extension DateComponentsFormatter {

    // MARK: + fullTimeFormatter

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static let fullTimeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        return formatter
    }()

}