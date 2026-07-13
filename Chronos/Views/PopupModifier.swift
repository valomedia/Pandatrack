//
//  Popup.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: Popup

struct PopupModifier<Popup: View>: ViewModifier {

    // MARK: - Life cycle methods

    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Popup) {
        _isPresented = isPresented
        popup = content
    }

    // MARK: - Properties

    @Binding var isPresented: Bool

    // MARK: - Methods

    let popup: () -> Popup

    func body(content: Content) -> some View {
        content.background(PopupController(isPresented: $isPresented, popup: popup))
    }

}
