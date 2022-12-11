//
//  TimeInterval+hours.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-10.
//
//

import Foundation


// MARK: TimeInterval

extension TimeInterval {

    // MARK: + hours

    var hours: Double {
        minutes / 60.0
    }
}