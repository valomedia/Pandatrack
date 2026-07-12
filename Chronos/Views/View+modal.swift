//
//  View+modal.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: View

extension View {

    // MARK: + modal

    @ViewBuilder
    func modal<Content: View, S: StringProtocol>(
            _ title: S? = nil,
            isPresented: Binding<Bool>,
            onOpen: (() -> Void)? = nil,
            onClose: (() -> Void)? = nil,
            @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: isPresented) { Modal(title, onOpen: onOpen, onClose: onClose, content: content) }
    }

}
