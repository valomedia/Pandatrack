//
//  Popup.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-01-28.
//
//

import Foundation
import SwiftUI


// MARK: Popup

/// Undocumented.
///
/// - Todo: Document.
///
struct PopupModifier<Popup: View>: ViewModifier {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - isPresented:
    ///     - content:
    ///
    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Popup) {
        _isPresented = isPresented
        popup = content
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    @Binding var isPresented: Bool

    // MARK: - Methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let popup: () -> Popup

    func body(content: Content) -> some View {
        content.background(PopupController(isPresented: $isPresented, popup: popup))
    }

}
