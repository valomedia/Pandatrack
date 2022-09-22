//
//  Color+secondaryForeground.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI


// MARK: Color

// MARK: + secondaryForeground

extension Color {

    // MARK: - Static properties

    /// The color for text labels that contain secondary content.
    ///
    static var secondaryForeground: Color {
        Color(UIColor.secondaryLabel)
    }
}