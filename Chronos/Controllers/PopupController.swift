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

struct PopupController<Popup: View>: UIViewControllerRepresentable {

    // MARK: - Life cycle methods

    init(isPresented: Binding<Bool>, @ViewBuilder popup: @escaping () -> Popup) {
        self._isPresented = isPresented
        self.popup = popup
    }

    // MARK: - Properties

    @Binding var isPresented: Bool

    // MARK: - Methods

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
