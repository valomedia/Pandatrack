//
//  Color+secondaryBackground.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-22.
//
//

import Foundation
import SwiftUI


// MARK: Color

// MARK: + secondaryBackground

extension Color {

    // MARK: - Static properties

    /// The color for text secondaryBackgrounds that contain primary content.
    ///
    static var secondaryBackground: Color {
        Color(UIColor.secondarySystemBackground)
    }
}