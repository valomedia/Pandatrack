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

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - image:
    ///     - title:
    ///     - headline:
    ///     - caption:
    ///
    init(title: String = "There is nothing here", headline: String, caption: String? = nil, image: Image? = nil) {
        self.title = title
        self.headline = headline
        self.caption = caption
        self.image = image
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let image: Image?

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
    let caption: String?

    var body: some View {
        Wrapper {
            VStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                Text(headline)
                    .font(.headline)
                    .foregroundColor(.white)
                if let caption {
                    Text(caption)
                            .font(.caption)
                            .padding(.top)
                }
                if let image = image {
                    HStack {
                        Spacer()
                        image.resizable().aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                            .padding(.top)
                }
                Spacer()
            }
                    .padding()
                    .background(Color(uiColor: Asset.noContentViewBackgroundColor.color))
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
