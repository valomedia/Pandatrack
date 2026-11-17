//
//  ThemeView.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: ThemeView

struct ThemeView: View {

    // MARK: - Properties

    let theme: Theme

    var body: some View {
        HStack {
            Label(theme.name, systemImage: "paintpalette").labelStyle(.iconOnly)
            ZStack {
                if theme == .none {
                    RoundedRectangle(cornerRadius: 4).stroke(theme.foregroundColor)
                } else {
                    RoundedRectangle(cornerRadius: 4).fill(theme.backgroundColor)
                }
                Text(theme.name)
                        .lineLimit(1)
                        .padding(4)
                        .padding(.horizontal)
            }
                    .foregroundColor(theme.foregroundColor)
                    .fixedSize(horizontal: false, vertical: true)
        }
    }

}


// MARK: ThemeView_Previews

struct ThemeView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        ThemeView(theme: .yellow).previewLayout(.sizeThatFits)
    }

}
