//
//  TimeInterval+formatter.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: TimeInterval

extension TimeInterval {

    // MARK: + formatter

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        return formatter
    }()

}