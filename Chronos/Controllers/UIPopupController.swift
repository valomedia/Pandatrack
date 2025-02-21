//
//  UIPopupController.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-02-01.
//
//

import Foundation
import SwiftUI


// MARK: UIPopupController

class UIPopupController<Popup: View>: UIViewController, UIPopoverPresentationControllerDelegate {

    // MARK: - Life cycle methods

    init(onDismiss: @escaping () -> ()) {
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle:nil)
    }

    @available(*, unavailable)
    @MainActor
    @objc
    required dynamic init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    var hostingController: UIHostingController<Popup>?

    // MARK: - Methods

    let onDismiss: () -> Void

    func presentPopup(popup: () -> Popup) {
        let hostingController: UIHostingController<Popup>
        if self.hostingController != nil {
            hostingController = self.hostingController!
            hostingController.rootView = popup()
        } else {
            hostingController = UIHostingController(rootView: popup())
            self.hostingController = hostingController
            hostingController.modalPresentationStyle = .popover
            hostingController.popoverPresentationController?.sourceView = view
            hostingController.popoverPresentationController?.sourceRect = view.bounds
            hostingController.popoverPresentationController?.delegate = self
            present(hostingController, animated: true)
        }
        hostingController.preferredContentSize = hostingController.sizeThatFits(in: UIView.layoutFittingExpandedSize)
    }

    func dismissPopup() {
        defer { hostingController = nil }
        guard let hostingController, !hostingController.isBeingDismissed else { return }
        hostingController.dismiss(animated: true)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }

    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        hostingController = nil
        onDismiss()
    }

}
