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

    var body: some View {
        ZStack {
            if theme == .none {
                RoundedRectangle(cornerRadius: 4).stroke(theme.foregroundColor)
            } else {
                RoundedRectangle(cornerRadius: 4).fill(theme.backgroundColor)
            }
            Text(theme.name)
                    .padding(4)
                    .padding(.horizontal)
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

    static var previews: some View {
        ThemeView(theme: .yellow).previewLayout(.sizeThatFits)
    }

}
