//
//  Color+tertiaryForeground.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI


// MARK: Color

// MARK: + tertiaryForeground

extension Color {

    // MARK: - Static properties

    /// The color for text labels that contain tertiary content.
    ///
    static var tertiaryForeground: Color {
        Color(UIColor.tertiaryLabel)
    }
}