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
    @Binding var selection: Theme?

    var body: some View {
        HStack {
            Picker(selection: $selection) {
                ForEach(Theme.allCases) { theme in
                    HStack {
                        // Dummy text to make SwiftUI draw the list item separators all the way across.
                        Text("")
                        ThemeView(theme: theme).padding(.leading)
                    }
                            .tag((theme != Theme.none).then(theme))
                }
            } label: {
                Label {
                    Text("Theme").padding(.horizontal)
                } icon: {
                    Image(systemName: "paintpalette").foregroundColor(.accentColor)
                }
                        .labelStyle(.titleAndIcon)
            }
                    .pickerStyle(.navigationLink)
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

    static var previews: some View {
        NavigationView {
            Form {
                List { ThemePicker(selection: .constant(.teal)) }
            }
        }
    }

}