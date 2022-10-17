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
public enum Theme: String, CaseIterable, Identifiable, Codable, CustomStringConvertible {
    case indigo
    case orange
    case purple
    case teal
    case yellow
    case none

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var foregroundColor: Color {
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
    public var backgroundColor: Color {
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
    public var name: String {
        rawValue.capitalized
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var id: String {
        rawValue
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    public var description: String {
        name
    }

}
