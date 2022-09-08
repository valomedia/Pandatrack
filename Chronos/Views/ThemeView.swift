//
//  ThemeView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//
//

import Foundation
import SwiftUI


// MARK: ThemeView

/// Undocumented.
///
/// - Todo: Document.
///
struct ThemeView: View {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let theme: Theme

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                    .fill(theme.backgroundColor)
            Label(theme.name, systemImage: "paintpalette")
                    .padding(4)
        }
                .foregroundColor(theme.foregroundColor)
                .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: ThemeView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct ThemeView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        ThemeView(theme: .yellow)
                .previewLayout(.sizeThatFits)
    }
}