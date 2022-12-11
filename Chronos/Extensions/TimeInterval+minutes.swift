//
//  TimeInterval+minutes.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-10.
//
//

import Foundation


// MARK: TimeInterval

extension TimeInterval {

    // MARK: + minutes

    var minutes: Double {
        self / 60.0
    }
}