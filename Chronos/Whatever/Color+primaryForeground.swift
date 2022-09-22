//
//  Color+primaryForeground.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI


// MARK: Color

// MARK: + primaryForeground

extension Color {

    // MARK: - Static properties

    /// The color for text labels that contain primary content.
    ///
    static var primaryForeground: Color {
        Color(UIColor.label)
    }
}