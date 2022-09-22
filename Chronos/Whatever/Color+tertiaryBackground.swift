//
//  Color+tertiaryBackground.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI


// MARK: Color

// MARK: + tertiaryBackground

extension Color {

    // MARK: - Static properties

    /// The color for text tertiaryBackgrounds that contain primary content.
    ///
    static var tertiaryBackground: Color {
        Color(UIColor.tertiarySystemBackground)
    }
}