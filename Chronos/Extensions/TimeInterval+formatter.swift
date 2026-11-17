//
//  TimeInterval+formatter.swift
//  Chronos
//

import Foundation


// MARK: TimeInterval

extension TimeInterval {

    // MARK: + formatter

    static let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        return formatter
    }()

}
