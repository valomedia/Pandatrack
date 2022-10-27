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
enum Theme: String, CaseIterable, Identifiable, Codable, CustomStringConvertible, ExpressibleByNilLiteral {
    case indigo
    case orange
    case purple
    case teal
    case yellow
    case none

    // MARK: - Life cycle methods

    init(nilLiteral: ()) {
        self = .none
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var foregroundColor: Color {
        switch self {
        case .orange, .teal, .yellow:
            return .black
        case .indigo, .purple:
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
        //Color(rawValue)
        switch self {
        case .indigo:
            return .indigo
        case .orange:
            return .orange
        case .purple:
            return .purple
        case .teal:
            return .teal
        case .yellow:
            return .yellow
        case .none:
            return .tertiaryBackground
        }
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
