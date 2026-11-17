//
//  View+popup.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: View

// MARK: + popup

extension View {

    func popup<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(PopupModifier(isPresented: isPresented, content: content))
    }

}
