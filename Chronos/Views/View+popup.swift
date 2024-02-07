//
//  View+popup.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-01-28.
//
//

import Foundation
import SwiftUI


// MARK: View

// MARK: + popup

extension View {

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - isPresented:
    ///     - content:
    ///
    func popup<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(PopupModifier(isPresented: isPresented, content: content))
    }

}