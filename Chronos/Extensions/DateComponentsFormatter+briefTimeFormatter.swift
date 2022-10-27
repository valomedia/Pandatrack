//
//  DateComponentsFormatter+briefTimeFormatter.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: DateComponentsFormatter

extension DateComponentsFormatter {

    // MARK: + briefTimeFormatter

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static let briefTimeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.collapsesLargestUnit = true
        formatter.unitsStyle = .brief
        return formatter
    }()

}