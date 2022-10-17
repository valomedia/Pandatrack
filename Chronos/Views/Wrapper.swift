//
//  Wrapper.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-10.
//
//

import Foundation
import SwiftUI


// MARK: Wrapper

/// Undocumented.
///
/// - Todo: Document.
///
struct Wrapper<Content: View>: View {

    // MARK: - Life cycle methods

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    // MARK: - Properties

    var body: some View {
        content()
    }

    // MARK: - Methods

    /// Undocumented
    ///
    /// - Todo: Document
    ///
    var content: () -> Content

}
