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
            Image(systemName: "paintpalette")
                    .padding(.trailing)
                    .foregroundColor(.accentColor)
            Picker(selection: $selection) {
                ForEach(Theme.allCases) { theme in
                    HStack {
                        // Dummy text to make SwiftUI draw the list item separators all the way across.
                        Text("")
                        Spacer()
                        ThemeView(theme: theme)
                    }
                            .tag((theme != Theme.none).then(theme))
                }
            } label: {
                HStack {
                    Text("Theme")
                    Spacer()
                }
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