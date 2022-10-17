//
//  LeadingIconLabelStyle.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-07.
//
//

import Foundation
import SwiftUI


// MARK: LeadingIconLabelStyle

/// Undocumented.
///
/// - Todo: Document.
///
struct LeadingIconLabelStyle: LabelStyle {

    // MARK: Methods

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon.frame(width: 10)
            configuration.title
        }
    }

}

// MARK: LabelStyle

// MARK: + LeadingIconLabelStyle

/// Undocumented.
///
/// - Todo: Document.
///
extension LabelStyle where Self == LeadingIconLabelStyle {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var leadingIcon: Self {
        Self()
    }

}
