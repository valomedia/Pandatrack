//
//  Wrapper.swift
//  Chronos
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

    var content: () -> Content

}
