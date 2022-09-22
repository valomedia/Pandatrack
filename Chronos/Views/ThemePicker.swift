//
//  ThemePicker.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//
//

import Foundation
import SwiftUI


// MARK: ThemePickerView

/// Undocumented.
///
/// - Todo: Document.
///
struct ThemePicker: View {

    // - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @Binding
    var selection: Theme

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                        .tag(theme)
            }
        }
    }
}

// MARK: ThemePicker_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct ThemePicker_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    static var previews: some View {
        ThemePicker(selection: .constant(.teal))
                .previewLayout(.sizeThatFits)
    }
}