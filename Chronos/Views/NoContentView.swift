//
//  NoContentView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation
import SwiftUI


// MARK: NoContentView

/// Undocumented.
///
/// - Todo: Document.
///
struct NoContentView: View {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let image: Image? = nil

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let title: String

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let headline: String

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let caption: String

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    var body: some View {
        Wrapper{
            VStack {
                if let image = image {
                    image
                }
                Text(title)
                        .font(.title)
                        .padding(.bottom)
                Text(headline)
                        .font(.headline)
                Text(caption)
                        .font(.caption)
                        .padding(.top)
                Spacer()
            }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .multilineTextAlignment(.center)
        }
                .padding()
    }

    // MARK: - Methods
}

// MARK: NoContentView_Previews

/// Undocumented.
///
/// - Todo: Document
///
class NoContentView_Previews: PreviewProvider {

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var previews: some View {
        NoContentView(
                title: "Lorem Ipsum",
                headline: "Lorem Ipsum Dolor Sit Amet",
                caption: """
                         Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut \
                         labore et dolore magna aliqua.
                         """)
    }

}
