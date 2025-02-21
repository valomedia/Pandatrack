//
//  View+modal.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
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
