//
//  PopupModifierController.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-02-01.
//
//

import Foundation
import SwiftUI


// MARK: PopupModifierController

/// Undocumented.
///
/// - Todo: Document.
///
struct PopupController<Popup: View>: UIViewControllerRepresentable {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - isPresented:
    ///     - popup:
    ///
    init(isPresented: Binding<Bool>, @ViewBuilder popup: @escaping () -> Popup) {
        self._isPresented = isPresented
        self.popup = popup
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

    func makeUIViewController(context: UIViewControllerRepresentableContext<PopupController<Popup>>)
            -> UIPopupController<Popup> {
        UIPopupController {
            isPresented = false
        }
    }

    func updateUIViewController(
            _ uiViewController: UIPopupController<Popup>,
            context: UIViewControllerRepresentableContext<PopupController<Popup>>) {
        isPresented ? uiViewController.presentPopup(popup: popup) : uiViewController.dismissPopup()
    }

}
