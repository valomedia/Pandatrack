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

/// Undocumented.
///
/// - Todo: Document.
///
enum Theme: String, CaseIterable, Identifiable, Codable, CustomStringConvertible, Equatable {
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
    case none

    init() {
        self = .none
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var foregroundColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow:
            return .black
        case .indigo, .magenta, .navy, .oxblood, .purple:
            return .white
        case .none:
            return .primaryForeground
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var backgroundColor: Color {
        Color(rawValue)
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var name: String {
        rawValue.capitalized
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var id: String {
        rawValue
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var description: String {
        name
    }

}
