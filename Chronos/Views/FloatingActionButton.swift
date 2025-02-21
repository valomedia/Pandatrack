//
//  FloatingActionButton.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-18.
//
//

import Foundation
import SwiftUI


// MARK: FloatingActionButton

struct FloatingActionButton: View {

    // MARK: - Life cycle methods

    init(image: Image? = nil, action: (()->())? = nil) {
        self.image = image ?? Image(systemName: "plus")
        self.action = action ?? {}
    }

    // MARK: - Properties

    let image: Image

    var body: some View {
        Button(action: action) {
            image
                    .imageScale(.large)
                    .padding()
        }
                .buttonStyle(.plain)
                .if(colorScheme == .light) { $0.colorInvert() }
                .background(Circle().fill(Color.accentColor))
                .padding()
    }

    @Environment(\.colorScheme)
    private var colorScheme: ColorScheme

    // MARK: - Methods

    let action: ()->()

}


// MARK: FloatingActionButton_Previews

class FloatingActionButton_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        FloatingActionButton()
                .previewLayout(.sizeThatFits)
    }

}
