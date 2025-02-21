//
//  DeleteButton.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-28.
//
//

import Foundation
import SwiftUI


// MARK: DeleteButton

struct DeleteButton: View {

    // MARK: - Life cycle methods

    init(
            buttonText: LocalizedStringKey,
            confirmationQuestion: LocalizedStringKey,
            supplementalMessage: LocalizedStringKey? = nil,
            action: @escaping () -> Void) {
        self.buttonText = buttonText
        self.confirmationQuestion = confirmationQuestion
        self.supplementalMessage = supplementalMessage
        self.action = action
    }

    // MARK: - Properties

    let buttonText: LocalizedStringKey

    let confirmationQuestion: LocalizedStringKey

    let supplementalMessage: LocalizedStringKey?

    var body: some View {
        Button(role: .destructive, action: { isPresentingConfirmationDialog = true }) {
            HStack {
                Spacer()
                Text(buttonText)
                Spacer()
            }
        }
                .confirmationDialog(
                        confirmationQuestion,
                        isPresented: $isPresentingConfirmationDialog,
                        titleVisibility: .visible) {
                    Button(buttonText, role: .destructive, action: action)
                } message: {
                    if let supplementalMessage { Text(supplementalMessage) }
                }
    }

    @State private var isPresentingConfirmationDialog = false

    // MARK: - Methods

    var action: () -> Void

}


// MARK: DeleteButton_Previews

class DeleteButton_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List {
                Section {
                    DeleteButton(
                            buttonText: "Delete all the things!",
                            confirmationQuestion: "Really delete all the things?") {}
                }
            }
        }
    }

}
