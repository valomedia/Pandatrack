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

/// Undocumented.
///
/// - Todo: Document.
///
struct FloatingActionButton: View {

    // MARK: - Static properties

    // MARK: - Static methods

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - image:
    ///     - action:
    ///
    init(image: Image? = nil, action: (()->())? = nil) {
        self.image = image ?? Image(systemName: "plus")
        self.action = action ?? {}
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let image: Image

    var body: some View {
        Button(action: action) {
            image
                    .imageScale(.large)
                    .padding()
        }
                .buttonStyle(.plain)
                .colorInvert()
                .background(Circle().fill(Color.accentColor))
                .shadow(radius: 2, x: 1, y: 1)
                .padding()
    }

    // MARK: - Methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let action: ()->()

}


// MARK: FloatingActionButton_Previews

/// Undocumented.
///
/// - Todo: Document.
///
class FloatingActionButton_Previews: PreviewProvider {


    // MARK: - Static properties

    static var previews: some View {
        FloatingActionButton()
                .previewLayout(.sizeThatFits)
    }

}