//
//  Theme.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-08.
//
//

import Foundation
import SwiftUI


// MARK: Theme

enum Theme: String, CaseIterable, Identifiable, Codable, CustomStringConvertible, Equatable {
    case none
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow

    init() {
        self = .none
    }

    // MARK: - Properties

    var foregroundColor: Color {
        switch self {
        case .none:
            return .primaryForeground
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow:
            return .black
        case .indigo, .magenta, .navy, .oxblood, .purple:
            return .white
        }
    }

    var backgroundColor: Color {
        Color(rawValue)
    }

    var name: String {
        rawValue.capitalized
    }

    var id: String {
        rawValue
    }

    var description: String {
        name
    }

}
